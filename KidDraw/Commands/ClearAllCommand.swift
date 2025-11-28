class ClearAllCommand: DrawingCommand {
    private let previousStrokes: [Stroke]
    private weak var model: DrawingViewModel?
    
    init(model: DrawingViewModel) {
        self.previousStrokes = model.strokes
        self.model = model
    }
    
    func execute() {
        model?.strokes.removeAll()
    }
    
    func undo() {
        model?.strokes = previousStrokes
    }
}
