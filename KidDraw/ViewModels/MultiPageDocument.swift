import SwiftUI
import Combine

class MultiPageDocument: ObservableObject {
    @Published var pages: [Page] = []
    @Published var selectedPageId: UUID?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(document: DrawingDocument) {
        self.pages = document.pages
        
        $pages
            .sink{ newPages in
                document.pages = newPages
            }
            .store(in: &cancellables)
    }
    
    var selectedPage: Page? {
        pages.first(where: {$0.id == selectedPageId})
    }
    
    func page(at index: Int) -> Page? {
        guard pages.indices.contains(index) else {return nil}
        return pages[index]
    }
    
    func addPage() -> Page {
        let page = Page()
        pages.append(page)
        selectedPageId = page.id
        return page
    }
    
    func insert( page: Page, at index: Int) {
        self.pages.insert(page, at: index)
    }
    
    func removePage(at index: Int) {
        guard pages.indices.contains(index) else {return}
        pages.remove(at: index)
        let newIndex = max(0, index - 1)
        if pages.count > newIndex {
            selectedPageId = pages[newIndex].id
        } else {
            selectedPageId = nil
        }
    }
    
    func removePage(page: Page) {
        if let index = pages.firstIndex(where: {$0.id == page.id}) {
            pages.remove(at: index)
        }
    }
    
    func movePage(from source: IndexSet, to destination: Int) {
        pages.move(fromOffsets: source, toOffset: destination)
    }
}
