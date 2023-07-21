class StepCounter{
    var totalSteps: Int = 0{
        willSet{
            print("About to set totalSteps to \(newValue)")
        }
        didSet{
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
                print(oldValue)
            }
        }
    }
}


let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
