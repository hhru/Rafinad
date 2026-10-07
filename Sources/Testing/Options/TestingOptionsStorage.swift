import Foundation

internal final class TestingOptionsStorage: @unchecked Sendable {

    private let lock = NSLock()

    private var unsafeOptions: TestingOptions

    internal var options: TestingOptions {
        get { lock.withLock { unsafeOptions } }
        set { lock.withLock { unsafeOptions = newValue } }
    }

    internal init(options: TestingOptions) {
        unsafeOptions = options
    }
}

extension TestingOptionsStorage {

    internal static let current = TestingOptionsStorage(options: .default)
}
