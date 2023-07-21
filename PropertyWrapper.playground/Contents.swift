@propertyWrapper
struct SmallNumber{
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int{
        get { return number }
        set { number = min(newValue, maximum)}
    }
    
    init() {
        maximum = 12
        number = 0
        
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int){
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}


struct ZeroRectangle{
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)

struct UnitRectangle{
    @SmallNumber(wrappedValue: 1) var height: Int
    @SmallNumber(wrappedValue: 1) var width: Int
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

enum Size{
    case small, large
}

//struct SizedRectangle{
//    @SmallNumber var height: Int
//    @SmallNumber var width: Int
//
//    mutating func resize(to size: Size) -> Bool{
//        switch size{
//        case .small:
//            height = 10
//            width = 20
//        case .large:
//            height = 100
//            width = 100
//        }
//        return $height || $width
//
//    }
//}

class Age{
    var age: Int = 5
    static let human = true
}

let children = Age()
var mom = Age()

print(Age.human)

print(mom.age)
print(mom)
