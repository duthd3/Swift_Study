import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise(){
        
    }
}

class Car: Vehicle{
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

class AutomaticCar: Car {
    
    override var currentSpeed: Double{
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 55
print(automatic.gear)
