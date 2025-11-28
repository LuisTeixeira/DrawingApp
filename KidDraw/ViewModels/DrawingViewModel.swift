import SwiftUI
import Combine

class DrawingViewModel: ObservableObject {
    @Published var strokes: [Stroke] = []
    @Published var currentStroke: Stroke?
    @Published var currentColor: Color = .black
    @Published var currentBrush: BrushType = .pen
    @Published var currentSize: BrushSize = .medium

    private var cancellables = Set<AnyCancellable>()
    
    let commandManager = CommandManager()
    
    init(document: DrawingDocument) {
        self.strokes = document.strokes
        
        $strokes
            .sink{ newStrokes in
                document.strokes = newStrokes
            }
            .store(in: &cancellables)
    }

    func startStroke(at point: CGPoint) {
        currentStroke = Stroke(points: [point], color: currentColor, lineWidth: currentSize.rawValue, brush: currentBrush)
    }

    func addPoint(_ point: CGPoint) {
        currentStroke?.points.append(CGPointCodable(point))
    }

    func finishStroke() {
        if let stroke = currentStroke {
            let cmd = AddStrokeCommand(stroke: stroke, model: self)
            commandManager.perform(cmd)
        }
        currentStroke = nil
    }
}
