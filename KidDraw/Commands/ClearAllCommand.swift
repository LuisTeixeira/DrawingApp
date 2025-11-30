class ClearAllCommand: DrawingCommand {
    private let previousStrokes: [Stroke]
    private weak var page: Page?
    
    init(page: Page?) {
        self.previousStrokes = page?.strokes ?? []
        self.page = page
    }
    
    func execute() {
        page?.strokes.removeAll()
    }
    
    func undo() {
        page?.strokes = previousStrokes
    }
}

