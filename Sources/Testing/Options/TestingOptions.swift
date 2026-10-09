import Foundation

/// Глобальные настройки тестирования.
///
/// Настройки задаются через ``current`` и применяются ко всем тестам.
/// Их рекомендуется задавать один раз до запуска тестов:
///
/// ``` swift
/// TestingOptions.current = TestingOptions(
///     waitDefaultTimeout: 10,
///     waitSettleDelay: 0.3
/// )
/// ```
///
/// ## See Also
///
/// - ``Testing``
/// - ``TestingElement``
/// - ``TestingList``
public struct TestingOptions: Sendable, Equatable {

    /// Продолжительность ожидания по умолчанию в секундах.
    ///
    /// Используется всеми методами ожидания, если время ожидания не передано явно.
    /// Значение не должно быть отрицательным.
    public var waitDefaultTimeout: TimeInterval

    /// Продолжительность паузы после успешного ожидания в секундах.
    ///
    /// Пауза выполняется после того, как условие ожидания выполнилось, и не входит во время ожидания.
    /// Может быть полезна, чтобы дождаться завершения анимаций.
    ///
    /// Значение не должно быть отрицательным, нулевое значение отключает паузу.
    public var waitSettleDelay: TimeInterval

    /// Начальный интервал проверки условия ожидания в секундах.
    ///
    /// Значение должно быть положительным.
    public var waitPollInterval: TimeInterval

    /// Множитель, на который увеличивается интервал проверки условия после каждой неудачной проверки.
    ///
    /// Значение `1.0` означает постоянный интервал проверки.
    /// Значение должно быть не меньше `1.0`.
    public var waitPollIntervalMultiplier: Double

    /// Максимальный интервал проверки условия ожидания в секундах.
    ///
    /// Интервал проверки не увеличивается сверх этого значения.
    /// Значение должно быть положительным.
    public var waitPollIntervalLimit: TimeInterval

    /// Создает настройки тестирования.
    ///
    /// - Parameters:
    ///   - waitDefaultTimeout: Продолжительность ожидания по умолчанию в секундах.
    ///                         По умолчанию равно 4 секундам.
    ///   - waitSettleDelay: Продолжительность паузы после успешного ожидания в секундах.
    ///                      По умолчанию пауза отключена.
    ///   - waitPollInterval: Начальный интервал проверки условия ожидания в секундах.
    ///                       По умолчанию равен 0.2 секунды.
    ///   - waitPollIntervalMultiplier: Множитель интервала проверки условия ожидания.
    ///                                 По умолчанию равен 1.5.
    ///   - waitPollIntervalLimit: Максимальный интервал проверки условия ожидания в секундах.
    ///                            По умолчанию равен 2 секундам.
    public init(
        waitDefaultTimeout: TimeInterval = 4.0,
        waitSettleDelay: TimeInterval = .zero,
        waitPollInterval: TimeInterval = 0.2,
        waitPollIntervalMultiplier: Double = 1.5,
        waitPollIntervalLimit: TimeInterval = 2.0
    ) {
        self.waitDefaultTimeout = waitDefaultTimeout
        self.waitSettleDelay = waitSettleDelay
        self.waitPollInterval = waitPollInterval
        self.waitPollIntervalMultiplier = waitPollIntervalMultiplier
        self.waitPollIntervalLimit = waitPollIntervalLimit

        validate()
    }

    @discardableResult
    private func validate() -> Self {
        precondition(
            waitDefaultTimeout >= .zero,
            "TestingOptions.waitDefaultTimeout must be non-negative"
        )

        precondition(
            waitSettleDelay >= .zero,
            "TestingOptions.waitSettleDelay must be non-negative"
        )

        precondition(
            waitPollInterval > .zero,
            "TestingOptions.waitPollInterval must be positive"
        )

        precondition(
            waitPollIntervalMultiplier >= 1.0,
            "TestingOptions.waitPollIntervalMultiplier must be at least 1"
        )

        precondition(
            waitPollIntervalLimit > .zero,
            "TestingOptions.waitPollIntervalLimit must be positive"
        )

        return self
    }
}

extension TestingOptions {

    /// Настройки тестирования по умолчанию.
    public static let `default` = Self()

    /// Текущие глобальные настройки тестирования.
    ///
    /// Изменения применяются ко всем последующим ожиданиям,
    /// поэтому настройки рекомендуется задавать один раз до запуска тестов.
    ///
    /// По умолчанию равны ``default``.
    public static var current: Self {
        get { TestingOptionsStorage.current.options }
        set { TestingOptionsStorage.current.options = newValue.validate() }
    }
}
