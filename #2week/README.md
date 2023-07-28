# 03 Structures and Classes

# 개념

- 데이터를 encapsulate 하는 데 사용할 수 있는 커스텀 타입

```swift
struct Resolution {
    var width = 0  // Stored property
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

## **Instances**

- 구조체와 클래스의 선언은 blueprint에 불과하므로, 인스턴스를 생성해야 실제로 사용할 수 있음

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

## Accessing Properties

- 프로퍼티는 구조체나 클래스 내부에 선언된 변수나 상수를 의미하며, dot syntax를 통해 접근할 수 있음

```swift
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"
```

# Structures and Enumerations Are Value Type

- 타입이 변수나 상수에 할당되거나 함수로 전달될 때, 값이 복사되며 할당되는 타입을 value type이라 부름
- 구조체와 열거형은 value type이며, Swift의 기본 타입 대부분은 구조체로 만들어져있으므로 value type임

```swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"
```

## [Copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write)

- Value type을 복사할때, 실제 복사가 필요한 시점까지 복사를 연기하는 리소스 관리 기법
- 리소스가 변경되기 전까지 새로운 복사본을 만들지 않고 원본을 참조함
- 리소스가 변경되는 시점에 새로운 복사본을 만듦으로써 복사에 드는 비용을 줄임
- Swift의 배열, 딕셔너리, 문자열같은 자료형에서 사용되며, 커스텀 타입에서도 직접 구현해 사용 가능

### String

- Swift의 문자열은 value sementics를 따르며, copy-on-write를 사용해 문자열 데이터를 버퍼에 저장함
- 버퍼의 데이터는 문자열의 다른 복사본에서도 공유할 수 있으며, 데이터는 변경을 시도할 때 복사됨(lazy)
- 버퍼의 크기가 가득차면, 배열처럼 지수적으로 확장된 새로운 공간을 할당 받은 뒤, 그곳으로 이동함

```swift
struct String
```

# Classes Are Reference Type

- 타입이 변수나 상수에 할당되거나 함수로 전달될 때, 값이 복사되지 않는 타입을 reference type이라 부름
- 값을 복사하는 것 대신, 기존의 인스턴스를 참조함
- Reference type의 인스턴스를 상수로 선언해도, 상수에는 참조가 저장되므로 내부 프로퍼티는 변경 가능함

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"
```

# Struct vs Class vs Enum

- 열거형은 저장 프로퍼티를 가질 수 없지만, 연산 프로퍼티와 메서드를 정의할 수 있음

| 기능 | Struct | Class | Enum |
| --- | --- | --- | --- |
| 프로퍼티, 메서드 정의 | ✅ | ✅ | ✅ |
| Subscript 정의 | ✅ | ✅ | ✅ |
| Initializer 정의 | ✅ | ✅ | ✅ |
| Deinitializer 정의 | ⛔️ | ✅ | ⛔️ |
| Extend | ✅ | ✅ | ✅ |
| 프로토콜 채택 | ✅ | ✅ | ✅ |
| 상속 | ⛔️ | ✅ | ⛔️ |
| 타입 캐스팅 | ⛔️ | ✅ | ⛔️ |
| Reference counting | ⛔️ | ✅ | ⛔️ |

# ****Choosing Between Structures and Classes****

- 기본적으로 구조체 사용
- 구조체를 프로토콜과 함께 사용해 implementation을 공유함으로써 behavior 채택 가능
- Objective-C와의 interoperability가 필요한 경우, 클래스 사용
- 모델링 중인 데이터의 identity에 대한 제어가 필요한 경우, 클래스 사용

# 과제

- [Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures)
- [Choosing Between Structures and Classes](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes)
