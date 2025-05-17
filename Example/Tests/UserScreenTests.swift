import XCTest
import RafinadTesting

@MainActor
final class UserScreenTests: XCTestCase {

    let application = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testThatScreenTitleIsCorrect() {
        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users[0]
            .waitForHittable()
            .tap()

        application
            .screen(of: UserAccessibility.self)
            .title
            .waitForExistence()
            .assert(text: "User")
    }

    func testThatUserMainInfoIsCorrect() {
        let userIndex = 0
        let user = User.all[userIndex]

        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users[userIndex]
            .waitForHittable()
            .tap()

        application
            .screen(of: UserAccessibility.self)
            .perform { $0.name.assert(text: user.fullName) }
            .perform { $0.position.assert(text: user.position) }
    }

    func testThatUserContactsAreCorrect() {
        let userIndex = 0
        let user = User.all[userIndex]

        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users[userIndex]
            .waitForHittable()
            .tap()

        application
            .screen(of: UserAccessibility.self)
            .perform { $0.phoneNumber.assert(text: user.phoneNumber) }
            .perform { $0.emailAddress.assert(text: user.emailAddress) }
    }

    func testThatUserSkillsAreCorrect() {
        let userIndex = 0
        let user = User.all[userIndex]

        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users[userIndex]
            .waitForHittable()
            .tap()

        let skills = application
            .screen(of: UserAccessibility.self)
            .skills

        skills
            .items
            .assert(count: user.skills.count)

        for skill in user.skills {
            skills
                .items[skill]
                .assert(text: skill)
        }
    }

    func testThatUserAboutMeIsCorrect() {
        let userIndex = 0
        let user = User.all[userIndex]

        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users[userIndex]
            .waitForHittable()
            .tap()

        application
            .screen(of: UserAccessibility.self)
            .aboutMe
            .print()
            .waitForText(user.aboutMe)
    }

    func testThatGoodUserCanBeFavorited() {
        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users["iOS Developer"]
            .waitForHittable()
            .tap()

        application
            .screen(of: UserAccessibility.self)
            .favoriteToggle
            .assert(isEnabled: true)
            .assert(isSelected: false)
            .tap()
            .waitForSelected()
    }

    func testThatBadUserCannotBeFavorited() {
        application.launch()

        application
            .screen(of: UserListAccessibility.self)
            .content
            .users["Android Developer"]
            .waitForHittable()
            .tap()

        application
            .screen(of: UserAccessibility.self)
            .favoriteToggle
            .assert(isEnabled: false)
            .assert(isSelected: false)
            .tap()
            .waitForDeselected()
    }
}
