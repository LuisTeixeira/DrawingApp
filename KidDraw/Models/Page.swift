import SwiftUI
import Combine

class Page: ObservableObject, Identifiable, Codable {
    let id: UUID
    var strokes: [Stroke]
    
    init(strokes: [Stroke] = []) {
        id = UUID()
        self.strokes = strokes
    }
}
