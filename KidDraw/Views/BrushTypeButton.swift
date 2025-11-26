import SwiftUI

struct BrushTypeButton: View {
    let brush: BrushType
    let isSelected: Bool
    let action: () -> Void
    
    var icon: String {
        switch brush {
        case .pen: return "pencil"
        case .marker: return "highlighter"
        case .crayon: return "scribble"
        case .chalk: return "rectangle.portrait.and.arrow.right"
        case .paintBrush: return "paintbrush"
        }
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundStyle(isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(.primary))
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isSelected ? Color.accentColor.opacity(0.2) : .clear)
                )
        }
        .buttonStyle(.plain)
        .help(brush.rawValue.capitalized)
    }
}
