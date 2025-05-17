import SwiftUI

@Observable
class Router {

    var navigationPath = NavigationPath()

    func push(screen: Screen) {
        navigationPath.append(screen)
    }

    func pop() {
        navigationPath.removeLast()
    }
}
