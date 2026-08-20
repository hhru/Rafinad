//
//  Created on 20.08.2026.
//  Copyright © HeadHunter. All rights reserved.
//

import Foundation
import XCTest
import RafinadTesting

private struct TestingStub: Testing {

    let value: Int

    init(value: Int = .zero) {
        self.value = value
    }
}

final class TestingPerformTests: XCTestCase {

    func testThatActionIsNotPerformedWhenConditionIsAlreadySatisfied() {
        var performedActionsCount = 0

        TestingStub().perform(
            until: { true },
            timeout: 0.1,
            failing: false,
            action: {
                performedActionsCount += 1
            }
        )

        XCTAssertEqual(performedActionsCount, 0)
    }

    func testThatActionIsPerformedUntilConditionIsSatisfied() {
        let testing = TestingStub(value: 7)
        var receivedValues: [Int] = []

        testing.perform(
            until: { testing in receivedValues.count == 2 && testing.value == 7 },
            timeout: 1,
            failing: false,
            action: { testing in
                receivedValues.append(testing.value)
            }
        )

        XCTAssertEqual(receivedValues, [7, 7])
    }

    func testThatConditionSatisfiedAfterTimeoutDoesNotSucceed() {
        var performedActionsCount = 0
        var conditionChecksCount = 0

        _ = XCTExpectFailure("Condition result received after timeout must not be accepted") {
            TestingStub().perform(
                until: {
                    conditionChecksCount += 1

                    guard conditionChecksCount > 1 else {
                        return false
                    }

                    Thread.sleep(forTimeInterval: 0.2)
                    return true
                },
                timeout: 0.1,
                action: {
                    performedActionsCount += 1
                }
            )
        }

        XCTAssertEqual(performedActionsCount, 1)
        XCTAssertEqual(conditionChecksCount, 2)
    }

    func testThatConditionIsNotCheckedAfterActionExceedsTimeout() {
        var performedActionsCount = 0
        var conditionChecksCount = 0

        TestingStub().perform(
            until: {
                conditionChecksCount += 1
                return false
            },
            timeout: 0.1,
            failing: false,
            action: {
                performedActionsCount += 1
                Thread.sleep(forTimeInterval: 0.2)
            }
        )

        XCTAssertEqual(performedActionsCount, 1)
        XCTAssertEqual(conditionChecksCount, 1)
    }
}
