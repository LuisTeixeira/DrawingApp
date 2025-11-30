import SwiftUI
import Combine

class PageThumbnailViewModel: ObservableObject {
    @Published var strokes: [Stroke] = []
    
    init(strokes: [Stroke]) {
        self.strokes = strokes
    }
}
