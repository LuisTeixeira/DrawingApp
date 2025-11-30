import SwiftUI
import Combine

class StrokeStyleState: ObservableObject {
    @Published var currentColor: Color = .black
    @Published var currentBrush: BrushType = .pen
    @Published var currentSize: BrushSize = .medium
}
