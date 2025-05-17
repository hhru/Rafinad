import SwiftUI

struct Tags: View {

    let items: [String]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(items, id: \.self) { tag in
                Text(tag)
                    .font(.subheadline)
                    .padding(8)
                    .background(.quinary)
                    .clipShape(.rect(cornerRadius: 8))
                    .accessibilityKey(\TagsAccessibility.items, item: tag)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    Tags(
        items: [
            "iOS",
            "macOS",
            "tvOS"
        ]
    )
}
