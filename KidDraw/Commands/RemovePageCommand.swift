import SwiftUI

class RemovePageCommand: DrawingCommand {
    private let document: MultiPageDocument
    private let pageIndex: Int
    private var removedPage: Page?
    
    init(document: MultiPageDocument, pageIndex: Int) {
        self.document = document
        self.pageIndex = pageIndex
    }
    
    func execute() {
        self.removedPage = document.page(at: self.pageIndex)
        document.removePage(at: self.pageIndex)
    }
    
    func undo() {
        guard let unwrappedPage = self.removedPage else { return }
        document.insert(page: unwrappedPage, at: self.pageIndex)
    }
}
