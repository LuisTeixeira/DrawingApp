import SwiftUI

struct CodableColor: Codable, Equatable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    init(_ color: Color) {
        let nsColor = NSColor(color)  // Convert SwiftUI Color → NSColor
                
        let rgbColor = nsColor.usingColorSpace(.sRGB) ?? NSColor.white
        
        self.red   = rgbColor.redComponent
        self.green = rgbColor.greenComponent
        self.blue  = rgbColor.blueComponent
        self.alpha = rgbColor.alphaComponent
    }
    
    var swiftUIColor: Color {
        Color(.sRGB, red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
