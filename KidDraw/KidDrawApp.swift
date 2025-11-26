import SwiftUI

@main
struct KidDrawApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: { DrawingDocument() }) { file in
            ContentView(model: DrawingViewModel(document: file.document))
        }
    }
}
