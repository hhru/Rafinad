import Foundation

extension AnyKeyPath {

    @_spi(Private)
    public func accessibilityIdentifier(item: String? = nil) -> String {
        let separator = "."

        let rootType = String(reflecting: Self.rootType)
            .components(separatedBy: separator)
            .dropFirst()
            .joined(separator: separator)

        let path = String(describing: self)
            .components(separatedBy: separator)
            .dropFirst()
            .joined(separator: separator)

        let identifier = "\(rootType)\(separator)\(path)"

        return item.map { "\(identifier)[\($0)]" } ?? identifier
    }
}
