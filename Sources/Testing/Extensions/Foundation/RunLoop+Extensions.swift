import Foundation

extension RunLoop {

    internal func run(for duration: TimeInterval) {
        let timeoutDate = Date(timeIntervalSinceNow: duration)

        // RunLoop может завершиться немедленно, если у него нет источников событий,
        // поэтому запускаем его повторно, пока не истечет указанное время.
        while Date() < timeoutDate {
            run(until: timeoutDate)
        }
    }
}
