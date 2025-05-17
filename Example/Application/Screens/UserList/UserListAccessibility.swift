import Rafinad

final class UserListAccessibility: ScreenAccessibility {

    final class Content: ViewAccessibility, SwipeableAccessibility {
        let searchField = TextFieldAccessibility()
        let users = [CellAccessibility]()
    }

    let content = Content()
}
