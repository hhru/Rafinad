import Rafinad

final class UserAccessibility: ScreenAccessibility {

    let title = TextAccessibility()

    let avatar = AvatarAccessibility()
    let name = TextAccessibility()
    let position = TextAccessibility()
    let favoriteToggle = FavoriteToggleAccessibility()

    let phoneNumber = TextAccessibility()
    let emailAddress = TextAccessibility()

    let skills = TagsAccessibility()
    let aboutMe = TextAccessibility()
}
