import SwiftUI

struct UserListView: View {

    @State
    private var searchText = ""

    @Environment(Router.self)
    private var router

    private var users: [User] {
        if searchText.isEmpty {
            return User.all
        }

        return User.all.filter { user in
            user.fullName.contains(searchText)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                TextField(
                    title: "Search",
                    value: $searchText
                )
                .accessibilityKey(\UserListAccessibility.content.searchField)
                .padding(16)

                ForEach(users, id: \.id) { user in
                    Cell(
                        avatar: Avatar(
                            url: user.photoURL,
                            placeholder: Image(.avatarPlaceholder),
                            size: .small
                        ),
                        title: user.fullName,
                        subtitle: user.position,
                        divider: users.last?.id != user.id
                            ? Divider()
                            : nil,
                        tapAction: {
                            router.push(screen: .user(user))
                        }
                    )
                    .accessibilityKey(\UserListAccessibility.content.users, item: user.position)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .accessibilityKey(\UserListAccessibility.content)
        .navigationTitle("Users")
    }
}

#Preview {
    NavigationStack {
        UserListView().environment(Router())
    }
}
