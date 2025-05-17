import SwiftUI

struct Cell: View {

    let avatar: Avatar?
    let title: String
    let subtitle: String
    let divider: Divider?

    let tapAction: (() -> Void)?

    var body: some View {
        HStack(spacing: .zero) {
            avatar?
                .accessibilityKey(\CellAccessibility.avatar)
                .padding([.vertical, .leading], 16)

            VStack(alignment: .leading, spacing: .zero) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title2)
                        .foregroundStyle(.primary)
                        .accessibilityKey(\CellAccessibility.title)

                    Text(subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .accessibilityKey(\CellAccessibility.subtitle)
                }
                .padding([.vertical, .trailing], 16)
                .frame(maxWidth: .infinity, alignment: .leading)

                divider?.accessibilityKey(\CellAccessibility.divider)
            }
            .padding(.leading, 16)
        }
        .onTapGesture { tapAction?() }
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    Cell(
        avatar: Avatar(
            url: nil,
            placeholder: Image(.avatarPlaceholder),
            size: .small
        ),
        title: "Title",
        subtitle: "Subtitle",
        divider: Divider(),
        tapAction: nil
    )
}
