import SwiftUI

struct Stroke: Identifiable, Codable, Equatable {
    let id: UUID
    var points: [CGPointCodable]
    var color: CodableColor
    var lineWith: CGFloat
    var brush: BrushType
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat, brush: BrushType) {
        self.id = UUID()
        self.points = points.map{ CGPointCodable($0) }
        self.color = CodableColor(color)
        self.lineWith = lineWidth
        self.brush = brush
    }
}
