import SwiftUI
import Combine

class DrawingViewModel: ObservableObject {
    @Published var strokes: [Stroke] = []
    @Published var currentStroke: Stroke?
    
    let commandManager: CommandManager
    let strokeStyleState: StrokeStyleState
    
    private var cancellables = Set<AnyCancellable>()
    
    init(page: Page, commandManager: CommandManager, strokeStyleState: StrokeStyleState) {
        self.strokes = page.strokes
        self.commandManager = commandManager
        self.strokeStyleState = strokeStyleState
        
        $strokes
            .sink { newStrokes in
                page.strokes = newStrokes
            }
            .store(in: &cancellables)
        
    }
    

    func startStroke(at point: CGPoint) {
        currentStroke = Stroke(points: [point], color: strokeStyleState.currentColor, lineWidth: strokeStyleState.currentSize.rawValue, brush: strokeStyleState.currentBrush)
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
