import UIKit
import Foundation

let fruits = ["Apple", "Pear", "Orange"]
let contacts = ["Adam" : 123456789, "James": 987654321, "Amy": 912837365]
let word = "supercalifragilisticexpialidocious"
let halfOpenRange = 1..<5
let closedRange = 1...5


for fruit in fruits {
    print(fruit)
}

for person in contacts {
    print(person.key)
    print(person.value)
}

for letter in word{
    print(letter)
}

for number in halfOpenRange{
    print(number)
}

for number2 in closedRange{
    print(number2)
}

let numberOfLegs = ["spider":8, "ant":6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}



let minutes  = 60
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
        print(tickMark)
}

