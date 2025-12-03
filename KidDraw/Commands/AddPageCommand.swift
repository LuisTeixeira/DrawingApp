import SwiftUI

class AddPageCommand: DrawingCommand {
    private let document: MultiPageDocument
    private var page: Page?
    
    init(document: MultiPageDocument) {
        self.document = document
    }
    
    func execute() {
        self.page = document.addPage()
    }
    
    func undo() {
        guard let unwrappedPage = page else { return }
        document.removePage(page: unwrappedPage)
    }
    
}
