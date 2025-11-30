import SwiftUI

struct PageThumbnailView: View {
    @ObservedObject var model: PageThumbnailViewModel
    
    var body: some View {
        GeometryReader { geo in
            Canvas { contex, size in
                guard let bounds = pageBounds(model: model) else {
                    return
                }
                
                let scaleX = size.width / bounds.width
                let scaleY = size.height / bounds.height
                let scale = min(scaleX, scaleY)
                
                let offsetX = (size.width - bounds.width * scale) / 2
                let offsetY = (size.height - bounds.height * scale) / 2
                
                let transform = CGAffineTransform.identity
                    .translatedBy(x: offsetX - bounds.minX * scale, y: offsetY - bounds.minY * scale)
                    .scaledBy(x: scale, y: scale)
                
                contex.transform = transform
                
                for stroke in model.strokes {
                    draw(stroke, in: contex)
                }
            }
            .background(Color.white)
            .border(Color.gray, width: 1)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func draw(_ stroke: Stroke, in context: GraphicsContext) {
        guard stroke.points.count > 1 else { return }
        
        var path = Path()
        path.addLines(stroke.points.map(\.point))
        
        let style: StrokeStyle
        
        switch stroke.brush {
        case .pen:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 0.2,
                lineCap: .round,
                lineJoin: .round
            )
            
        case .marker:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 1.8 * 0.2,
                lineCap: .round,
                lineJoin: .round
            )
            
        case .crayon:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 0.2,
                lineCap: .round,
                lineJoin: .round,
                dash: [stroke.lineWith/2]
            )
            
        case .chalk:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 1.25 * 0.2,
                lineCap: .round,
                lineJoin: .round,
                dash: [1, stroke.lineWith],
                dashPhase: stroke.lineWith / 2
            )
            
        case .paintBrush:
            style = StrokeStyle(
                lineWidth: stroke.lineWith * 2.2 * 0.2,
                lineCap: .round,
                lineJoin: .round
            )
        }
        
        context.stroke(path, with: .color(stroke.color.swiftUIColor), style: style)
    }

    private func pageBounds(model: PageThumbnailViewModel) -> CGRect? {
        let allPoints = model.strokes.flatMap { $0.points.map(\.point) }
        guard !allPoints.isEmpty else { return nil }
        return allPoints.reduce(into: CGRect.null) { rect, point in
            rect = rect.union(CGRect(origin: point, size: .zero))
        }
    }
}
