import SwiftUI

struct Divider: View {

    var body: some View {
        Color(.divider)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    Divider()
}
