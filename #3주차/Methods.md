# 05 Methods

# 개념

- 특정 타입의 인스턴스나 타입에 속한 함수
- Instance method와 type method로 분류됨

# Instance Methods

- 특정 클래스나 구조체, 열거형의 인스턴스에 속한 함수

```swift
class Counter {
    var count = 0

    func increment() { count += 1 }
    func increment(by amount: Int) { count += amount }

    func reset() { count = 0 }
}

let counter = Counter()   // the initial counter value is 0
counter.increment()       // the counter's value is now 1
counter.increment(by: 5)  // the counter's value is now 6
counter.reset()           // the counter's value is now 0
```

## The `self` Property

- 타입의 모든 인스턴스에는 인스턴스 자체를 의미하는 `self`라는 프로퍼티가 내부적으로 존재함
- 대부분의 경우, `self`를 명시적으로 작성하지 않아도 Swift가 알아서 추론해줌

```swift
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool { return self.x > x }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"
```

## `mutating`

### Modifying Value Types from Within Instance Methods

- 기본적으로, value type의 프로퍼티 값은 인스턴스 메서드 내부에서 변경할 수 없음
- 하지만 `mutating` 키워드를 사용함으로써, 프로퍼티의 값을 변경할 수 있음

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"

let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)  // fixedPoint가 상수이므로 에러 발생
```

### Assigning to `self` Withing a Mutating Method

- 프로퍼티의 값 뿐만 아니라, 인스턴스 자체도 변경할 수 있음

```swift
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()  // ovenLight is now equal to .high
ovenLight.next()  // ovenLight is now equal to .off
```

### 동작원리 (Copy-in Copy-out)

1. `mutating` 메서드가 호출되면, 메서드 내부에서 해당 인스턴스를 복사함
2. 메서드 내부 코드에 의해, 복사된 임시 인스턴스에 대한 변경이 이루어짐
3. 메서드의 실행이 완료되면, 원본 인스턴스가 복사된 임시 인스턴스로 교체됨

# Type Methods

- 특정 타입의 인스턴스가 아닌, 타입 자체에 속한 함수
- `static` 메서드와 `class` 메서드가 있으며, `class` 메서드는 서브클래스에서 오버라이딩이 가능함
- 타입 메서드 내부에서 `self`를 사용하면, 인스턴스가 아닌 타입 자체를 의미함

```swift
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String

    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }

    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) { print("player is now on level 6") } 
else { print("level 6 hasn't yet been unlocked") }
// Prints "level 6 hasn't yet been unlocked"
```
