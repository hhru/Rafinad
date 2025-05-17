import SwiftUI

struct Avatar: View {

    let url: URL?
    let placeholder: AnyView
    let size: AvatarSize

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .accessibilityKey(\AvatarAccessibility.image)
        } placeholder: {
            placeholder
                .accessibilityKey(\AvatarAccessibility.placeholder)
        }
        .frame(width: size.value, height: size.value)
        .clipShape(.capsule)
        .accessibilityElement(children: .contain)
    }

    init<Placeholder: View>(
        url: URL?,
        placeholder: Placeholder,
        size: AvatarSize = .large
    ) {
        self.url = url
        self.placeholder = AnyView(placeholder)
        self.size = size
    }
}

#Preview {
    Avatar(
        url: nil,
        placeholder: Image(.avatarPlaceholder),
        size: .small
    )
}
