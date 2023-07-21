import Foundation

class Animal {
    var name: String
    
    init(n: String){
        name = n
    }
}


class Human: Animal {
    func code() {
        print("Typing away...")
    }
}

struct Fish {
    func breatheUnderWater(){
        print("Breathing under water.")
    }
}

let angela = Human(n: "Angela Yu")
let jack = Human(n: "Jack Bauer")
let nemo = Fish()
let num = 12

let neighbours: [Any] = [angela, jack, nemo, num]
let neighbour1 = neighbours[0]

if neighbours[0] is Fish { //is는 TypeChecking 하는데 사용
    print("Human")
}

func findNemo(from animals: [Animal]){
    for animal in animals{
        if animal is Fish{
            print(animal.name)
            let fish = animal as! Fish
            fish.breatheUnderWater()
            
            
            
        }
        
    }
}

