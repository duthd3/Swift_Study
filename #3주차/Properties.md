# 04 Properties

# 개념

- 클래스, 구조체, 열거형의 인스턴스나 타입에 속한 값

# Stored Properties

- 클래스나 구조체의 인스턴스에 속한 상수나 변수
- 열거형에서는 선언 불가

```swift
struct FixedLengthRange {
    var firstValue: Int  // Variable stored properties
    let length: Int      // Constant stored properties
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```

## Stored Properties of Constant Structure Instances

- 구조체의 인스턴스를 상수에 할당하면, 인스턴스의 프로퍼티가 변수이더라도 변경이 불가함
- 이는 구조체가 value type이기 때문임

```swift
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```

## Lazy Stored Properties

- 처음 사용되기 전까지 값이 initialize 되지 않는 프로퍼티
- 즉, 처음 사용 전까지 초기 값이 없기 때문에, 항상 변수로 선언할 수 밖에 없음
- 처음 사용되고 나면, 일반 저장 프로퍼티처럼 동작함
- 여러 스레드에서 최초 사용을 위해 동시에 접근한다면, 여러 번 initialize 될 수 있는 위험이 있음

### Use Case

1. 프로퍼티가 사용되지 않을 수 있는 경우
2. 프로퍼티를 initialize 하는데 시간이 오래걸리는 경우
3. 프로퍼티가 외부에 의존하고 있는 경우

```swift
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created

print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"
```

# Computed Properties

- 값을 저장하지 않는 대신, 사용할 때마다 값을 계산해서 리턴하는 프로퍼티
- 다른 프로퍼티의 값을 간접적으로 검색할 수 있는 getter는 필수적으로 가져야하며, 다른 프로퍼티의 값을 설정할 수 있는 setter는 선택적으로 가질 수 있음
- 값이 고정되어있지 않으므로, 항상 `var` 키워드를 통해 변수로 선언해야함
- 클래스, 구조체, 열거형에서 정의할 수 있음

```swift
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {  // Computed property
        get {  // Getter
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {  // Setter
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(
    origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0)
)
let initialSquareCenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"
```

## Shorthand Setter and Getter Expression

- Setter가 설정할 새 값에 대한 이름을 정의해주지 않아도, `newValue` 라는 기본 이름으로 사용할 수 있음
- Getter의 body가 단일 expression이라면, `return` 키워드 생략할 수 있음

```swift
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(
                x: origin.x + (size.width / 2),
                y: origin.y + (size.height / 2)
            )
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
```

## Read-Only Computed Properties

- Setter 없이 getter만 있는 연산 프로퍼티
- Setter가 없기 때문에, 다른 값을 설정할 수 없음
- 아래와 같은 Shorthand 문법을 지원함
    
    ```swift
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double { width * height * depth }
    }
    
    let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
    print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
    // Prints "the volume of fourByFiveByTwo is 40.0"
    ```
    

# Property Observers

- 프로퍼티 값을 관찰하고, 변화에 반응함
- 프로퍼티의 값이 설정될 때마다 호출되며, `willSet`이나 `didSet` observer를 정의할 수 있음
- `willSet`은 값이 저장되기 직전에 호출되고, `didSet`은 새 값이 저장된 직후에 호출됨

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```

# Property Wrappers

- 프로퍼티가 저장되는 방식을 관리하는 코드와, 프로퍼티를 정의하는 코드의 layer를 분리함
- 이를 통해, 공통된 동작을 가진 여러 프로퍼티에서 코드를 재사용할 수 있음
- 프로퍼티 래퍼를 정의하려면, `wrappedValue` 프로퍼티를 포함하는 구조체나 열거형, 클래스를 정의해야함
- 프로퍼티 래퍼는 local stored variable에서만 사용할 수 있으며, 전역 변수나 computed variable에서는 사용할 수 없음

```swift
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"
```

## Setting Initial Values for Wrapped Properties

- 기존의 `SmallRectangle`에서는, `number`의 초기값 때문에 `height`와 `width`에 대한 초기값을 할당할 수 없었음
- 프로퍼티 래퍼는 initializer를 통해, 초기값 설정 등과 같은 customization을 지원할 수 있음

```swift
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"

mixedRectangle.width = 10
print(mixedRectangle.width)
// Prints "9"
```

## Projecting a Value From a Property Wrapper

- `projectedValue`를 통해 프로퍼티 래퍼에서 제공하는 값이나 기능을 노출할 수 있음
- 즉, `projectedValue`를 통해 프로퍼티의 상태에 대한 추가적인 정보를 얻을 수 있음
- 아래의 경우, 할당한 값의 조정 여부에 대한 정보를 제공함

```swift
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"
```

# Global and Local Variables

- 저장 프로퍼티, 계산 프로퍼티 모두 전역으로 선언 가능함
- 전역으로 선언된 변수나 상수는, `lazy` 키워드가 없어도 항상 lazy하게 동작함

# Type Properties

- 개별 인스턴스에 속하지 않고, 해당 타입 자체에 속하는 프로퍼티
- 타입의 모든 인스턴스에 보편적인 값을 정의하는데 사용하며, 그 값은 해당하는 타입의 모든 인스턴스에서 공유됨
- Initializer를 통해 값을 할당할 수 없기 때문에, 선언 시 항상 초기값을 제공해야함
- Lazy하게 동작하며, 여러 스레드에서 동시에 접근해도 한 번만 초기화됨

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int { return 1 }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int { return 6 }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int { return 27 }

    // class로 선언하면, 자식 클래스에서 오버라이딩 가능
    class var overrideableComputedTypeProperty: Int { return 107 }
}
```
