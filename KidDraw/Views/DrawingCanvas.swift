import SwiftUI

struct DrawingCanvas: View {
    @ObservedObject var model: DrawingViewModel
    
    var body: some View {
        Canvas { context, size in
            
            for stroke in model.strokes {
                draw(stroke, in: context)
            }
            
            if let stroke = model.currentStroke {
                draw(stroke, in: context)
            }
        }
        .background(Color.white)
        .contentShape(Rectangle())
        .gesture(drawingGesture)
    }
    
    private func draw(_ stroke: Stroke, in context: GraphicsContext) {
        guard stroke.points.count > 1 else { return }
        
        var path = Path()
        path.addLines(stroke.points.map(\.point))
        
        let style: StrokeStyle
        
        switch stroke.brush {
        case .pen:
            style = StrokeStyle(
                lineWidth: stroke.lineWith,
                lineCap: .round,
                lineJoin: .round
            )
            
        case .marker:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 1.8,
                lineCap: .round,
                lineJoin: .round
            )
            
        case .crayon:
            style = StrokeStyle(
                lineWidth: stroke.lineWith,
                lineCap: .round,
                lineJoin: .round,
                dash: [stroke.lineWith/2]
            )
            
        case .chalk:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 1.25,
                lineCap: .round,
                lineJoin: .round,
                dash: [1, stroke.lineWith],
                dashPhase: stroke.lineWith / 2
            )
            
        case .paintBrush:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 2.2,
                lineCap: .round,
                lineJoin: .round
            )
        }
        
        context.stroke(path, with: .color(stroke.color.swiftUIColor), style: style)
    }
    
    private var drawingGesture: some Gesture {
        
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let point = value.location
                
                if model.currentStroke == nil {
                    model.startStroke(at: point)
                } else {
                    model.addPoint(point)
                }
            }
            .onEnded { _ in
                model.finishStroke()
            }
    }
}
