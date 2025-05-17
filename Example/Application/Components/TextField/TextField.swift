import SwiftUI

struct TextField: View {

    let title: String

    @Binding
    var value: String

    @FocusState
    private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .trailing) {
            SwiftUI.TextField(title, text: $value)
                .padding(.trailing, value.isEmpty ? .zero : 24)
                .focused($isFocused)

            if !value.isEmpty {
                Button {
                    value.removeAll()
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityKey(\TextFieldAccessibility.clearButton)
            }
        }
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.divider))
        )
        .onTapGesture { isFocused = true }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    TextField(
        title: "Title",
        value: .constant("123")
    )
}
