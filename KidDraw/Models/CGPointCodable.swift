import CoreGraphics

struct CGPointCodable: Codable, Equatable {
    var x: CGFloat
    var y: CGFloat
    
    init(_ point: CGPoint) {
        self.x = point.x
        self.y = point.y
    }
    
    var point: CGPoint {
        CGPoint(x: x, y: y)
    }
}
