# ``Rafinad``

Удобный и компилируемый синтаксис для UI-тестирования iOS и tvOS приложений,
совместимый со SwiftUI и UIKit. 


## Overview

Rafinad предоставляет механизмы для более строго-типизированной идентификации UI-компонентов
для их удобного поиска и взаимодействия в UI-тестах.

Для этого Rafinad вводит 2 новых термина:
- term Accessibility-схема: Вспомогательный тип тестируемого UI-компонента или экрана,
который позволяет кратко описывать его структуру и возможности для тестов.
- term Accessibility-ключ: Аналог accessibility-идентификатора, 
который позволяет использовать key-path поля из accessibility-схемы 
в качестве идентификатора UI-компонента для его поиска в тестах.


### Пример 

В качестве примера возьмем простейший экран, который отображает информацию о пользователе.
Для простоты ограничимся только именем и должностью.

Чтобы использовать Rafinad для этого экрана в тестах, 
первым шагом следует добавить для него accessibility-схему,
наследуя базовый класс ``ScreenAccessibility``:

``` swift
import Rafinad

/// Accessibility-схема экрана с информацией о пользователе 
class UserAccessibility: ScreenAccessibility {

    let name = TextAccessibility()
    let position = TextAccessibility()
}
```

Далее необходимо установить accessibility-ключи для компонентов экрана,
используя key-path полей схемы:

``` swift
import SwiftUI

struct UserView: View {

    let user: User

    var body: some View {
        VStack(spacing: 4) {
            Text(user.name)
                .font(.largeTitle)
                // Установка ключа для имени пользователя
                .accessibilityKey(\UserAccessibility.name)

            Text(user.position)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                // Установка ключа для должности пользователя
                .accessibilityKey(\UserAccessibility.position)
        }
    }
}
```

Теперь наш экран готов к UI-тестированию, осталось добавить сами тесты:

``` swift
import XCTest
import RafinadTesting

@MainActor
final class UserScreenTests: XCTestCase {

    let application = XCUIApplication()

    func testThatUserNameIsCorrect() {
        application.launch()

        application
            .screen(of: UserAccessibility.self) // получение экрана пользователя
            .name // получение компонента с именем пользователя
            .waitForExistence() // ожидание появления компонента
            .assert(text: "Steve Jobs") // проверка имени
    }

    func testThatUserPositionIsCorrect() {
        application.launch()

        application
            .screen(of: UserAccessibility.self) // получение экрана пользователя
            .position // получение компонента с должностью пользователя
            .waitForText("CEO") // проверка текста должности
    }
}
```


### Импорты

Чтобы кодовая база приложений не имела лишних тестовых зависимостей, Rafinad разделен на 2 таргета:
- `Rafinad`: предоставляет общие сущности для использования в кодовой базе приложений
- `RafinadTesting`: предоставляет тестовые сущности для использования в кодовой базе тестов


## Topics


### Rafinad

- ``ViewAccessibility``
- ``TextAccessibility``
- ``ImageAccessibility``
- ``AnyAccessibility``
- ``ScreenAccessibility``

- ``DisableableAccessibility``
- ``EditableAccessibility``
- ``SelectableAccessibility``
- ``SwipeableAccessibility``
- ``RotatableAccessibility``
- ``PinchableAccessibility``

- ``AccessibilityKey``

### RafinadTesting

- ``TestingElement``
- ``TestingList``
- ``Testing``
