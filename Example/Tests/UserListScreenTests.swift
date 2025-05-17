import XCTest
import RafinadTesting

@MainActor
final class UserListScreenTests: XCTestCase {

    let application = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testThatUserCountIsCorrect() {
        let users = User.all

        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .waitForExistence()
            .users
            .assert(count: users.count)
    }

    func testThatUserInfoIsCorrect() {
        let userIndex = 0
        let user = User.all[userIndex]

        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .waitForExistence()
            .users[userIndex]
            .perform { $0.title.assert(text: user.fullName) }
            .perform { $0.subtitle.assert(text: user.position) }
    }

    func testThatSecondLastUserHasDivider() {
        application.launch()

        let userList = application
            .screen(of: UserListAccessibility.self)
            .content

        userList
            .waitForExistence()
            .users[User.all.count - 2]
            .assert(isExist: true)
            .divider
            .assert(isExist: true)
    }

    func testThatLastUserHasNoDivider() {
        application.launch()

        let userList = application
            .screen(of: UserListAccessibility.self)
            .content

        userList
            .waitForExistence()
            .users[User.all.count - 1]
            .assert(isExist: true)
            .divider
            .assert(isExist: false)
    }

    func testThatSearchFieldHasCorrectPlaceholder() {
        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .waitForExistence()
            .searchField
            .assert(placeholder: "Search")
    }

    func testThatSearchFieldIsFocusedOnTap() {
        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .searchField
            .waitForHittable()
            .assert(isFocused: false)
            .tap()
            .assert(isFocused: true)
    }

    func testThatSearchFieldLosesFocusOnSubmit() {
        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .searchField
            .waitForHittable()
            .tap()
            .assert(isFocused: true)
            .submitByKeyboard()
            .assert(isFocused: false)
    }

    func testThatSearchFieldLosesFocusOnScroll() {
        application.launch()

        let userList = application
            .screen(of: UserListAccessibility.self)
            .content

        userList
            .searchField
            .waitForHittable()
            .tap()
            .waitForFocused()
            .perform { userList.swipeUp() }
            .waitForUnfocused()
    }

    func testThatSearchFieldFiltersUsers() {
        let users = User.all
        let user = users[0]

        application.launch()

        let userList = application
            .screen(of: UserListAccessibility.self)
            .content

        userList
            .searchField
            .assert(isHittable: true)
            .tap()
            .typeText("qweasdzxc")
            .assert(text: "qweasdzxc")
            .perform { userList.users.assert(isEmpty: true) }
            .perform { $0.clearButton.tap() }
            .typeText(user.fullName)
            .waitForText(user.fullName)
            .perform { userList.users.assert(count: 1) }
            .clearByKeyboard()
            .submitByKeyboard()
            .perform { userList.users.assert(count: users.count) }
    }
}
