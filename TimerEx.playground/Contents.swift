import UIKit

let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)

@objc func fire(){
    print("Fire")
}
