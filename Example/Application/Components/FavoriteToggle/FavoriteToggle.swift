import SwiftUI

struct FavoriteToggle: View {

    @Binding
    var isSelected: Bool

    @Environment(\.isEnabled)
    private var isEnabled

    private var icon: Image {
        isEnabled && isSelected
            ? Image(systemName: "star.fill")
            : Image(systemName: "star")
    }

    private var color: Color {
        guard isEnabled else {
            return Color(.favoriteToggleDisabled)
        }

        return isSelected
            ? Color(.favoriteToggleSelected)
            : Color(.favoriteToggleUnselected)
    }

    var body: some View {
        icon
            .resizable()
            .foregroundStyle(color)
            .animation(.easeInOut(duration: 0.2), value: [isEnabled, isSelected])
            .frame(width: 24, height: 24)
            .padding(8)
            .onTapGesture { isSelected.toggle() }
            .accessibilityAddTraits(.isButton)
            .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    FavoriteToggle(isSelected: .constant(false))
}
