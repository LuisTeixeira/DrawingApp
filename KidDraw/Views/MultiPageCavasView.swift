import SwiftUI

struct MultiPageCavasView: View {
    @StateObject var document: MultiPageDocument
    @StateObject var commandManager: CommandManager
    @StateObject var strokeStyleState: StrokeStyleState
    
    var body: some View {
        NavigationSplitView {
            List(selection: $document.selectedPageId) {
                ForEach(Array(document.pages.enumerated()), id: \.1.id) { index, page in
                    PageThumbnailView(model: PageThumbnailViewModel(strokes: page.strokes))
                        .tag(page.id)
                        .frame(height: 80)
                        .padding(4)
                }
                .onDelete { indexSet in
                    indexSet.forEach {
                        let removePageCommand = RemovePageCommand(document: document, pageIndex: $0)
                        commandManager.perform(removePageCommand)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("New Page") {
                        let addPageCommand = AddPageCommand(document: document)
                        commandManager.perform(addPageCommand)
                    }
                    .keyboardShortcut("n", modifiers: [.command, .shift])
                }
            }
        } detail: {
            if let page = document.selectedPage {
                DrawingCanvas(model: DrawingViewModel(page: page, commandManager: commandManager, strokeStyleState: strokeStyleState))
            } else {
                Text("No pages")
            }
        }
    }
}
