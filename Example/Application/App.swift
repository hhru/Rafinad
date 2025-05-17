import SwiftUI
import Rafinad

@main
struct App: SwiftUI.App {

    @State
    private var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                UserListView()
                    .environment(router)
                    .navigationDestination(for: Screen.self) { screen in
                        switch screen {
                        case .userList:
                            UserListView().environment(router)

                        case let .user(user):
                            UserView(user: user).environment(router)
                        }
                    }
            }
        }
    }

    init() {
        #if !DEBUG
            AccessibilityKey.isEnabled = false
        #endif
    }
}
