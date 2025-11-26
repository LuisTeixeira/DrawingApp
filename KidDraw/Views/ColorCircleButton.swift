import SwiftUI

struct ColorCircleButton: View {
    var color: Color
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 18, height: 18)
                
                if isSelected {
                    Circle()
                        .strokeBorder(Color.primary, lineWidth: 2)
                        .frame(width: 22, height: 22)
                }
            }
        }
        .buttonStyle(.plain)
        .help(color.description.capitalized)
    }
}
