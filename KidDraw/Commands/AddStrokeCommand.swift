class AddStrokeCommand: DrawingCommand {
    private let stroke: Stroke
    private var model: DrawingViewModel?
    
    init(stroke: Stroke, model: DrawingViewModel) {
        self.stroke = stroke
        self.model = model
    }
    
    func execute() {
        model?.strokes.append(stroke)
    }
    
    func undo() {
        model?.strokes.removeAll { $0.id == stroke.id }
    }
}
