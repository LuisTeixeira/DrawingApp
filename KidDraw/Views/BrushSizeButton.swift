import SwiftUI

struct BrushSizeButton: View {
    let size: BrushSize
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(isSelected ? Color.primary : Color.secondary.opacity(0.4))
                .frame(width: size.rawValue * 2,
                       height: size.rawValue * 2)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isSelected ? Color.accentColor.opacity(0.2) : .clear)
                )
        }
        .buttonStyle(.plain)
        .help("\(sizeLabel)")
    }
    
    private var sizeLabel: String {
        switch size {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        }
    }
}
