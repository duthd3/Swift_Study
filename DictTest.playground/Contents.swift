import UIKit

var Dict = [5.5: 1, 5.6: 2, 5.7: 3, 5.9: 5, 6.0: 6, 6.1: 7, 6.2: 8]
var distance = 5.61
var arr: [Double] = []

var min = 100000.0

var minIndex = 0.0

for i in Dict.keys {
    if min > abs(i - distance){
        min = abs(i - distance)
        minIndex = i
    }
}
print(Dict[minIndex]!)


