import UIKit

let closure = { print("Hi, Somaker")}
closure()
// 클로저는 Named Closure & Unnamed Closure 둘다 포함하지만, 보통 Unnamed Closure를 말한다.

// 1급 객체 함수의 특성을 다 갖고있다.

let closure2 = {(name: String) -> String in
    return "Hello, \(name)"
}

closure2("Yeosong")

// 클로저에선 Argument Label을 사용하지 않는다. 따라서, name은 Argument Label이 아니고, 오직 Parameter Name이다.

//1급 객체로서 클로저
//1. 클로저를 변수나 상수에 대입할 수 있다.
let closure3 = closure2
//2. 함수의 파라미터 타입으로 클로저를 전달할 수 있다.
func doSomething(closure: () -> ()){
    closure()
}
//함수를 파라미터로 전달받는 doSomething이라는 함수에 파라미터로 함수를 넘겨줘도 되지만
doSomething(closure:{() -> () in
    print("Hellooo")
})
//이렇게 클로저를 넘겨줘도 된다.
//3. 함수의 반환 타입으로 클로저를 사용할 수 있다.
func doSomething2() -> () -> () {
    return { () -> () in
        print("Hello yeosong!")
        
    }
}
let closure4 = doSomething2()
closure4()

//클로저 실행하기
//1. 클로저가 대입된 변수나 상수로 호출하기
//2. 클로저를 직접 실행하기(완벽한 일회성) - 클로저를 () 로 감싸고, 마지막에 호출 구문인 ()를 추가해주면 된다.
({ () -> () in
    print("Hi, Yeosong")
    
})()
//######################클로저 경량 문법####################
//1. 트레일링 클로저(Trailing Closure)
// 함수의 마지막 파라미터가 클로저일 때, 이를 파라미터 값 형식이 아닌 함수 뒤에 붙여 작성하는 문법, 이때 Argument Label은 생략.
//1-1. 파라미터가 클로저 하나인 함수
func doSomething3(closure: () -> ()){
    closure()
}
doSomething3(closure: { () -> () in
    print("Helloww")
})
// Trailing Closure 에서는
doSomething3() { () -> () in
    print("hi")
}
// 파라미터 클로저 하나일 경우엔 호출구문인 ()도 생략 가능하다.
doSomething3 { () -> () in
    print("hihi")
    
}

//1-2. 파라미터가 여러개인 함수
func fetchData(success: () -> (), fail: ()->()){
    //do something...
    success()
    fail()
}

//Inline Closure의 경우
fetchData(success:{() -> () in
    print("Success!")
}, fail: {() -> () in
    print("Fail!")
})

fetchData(success:{() -> () in
    print("Success!")
}){() -> () in
    print("Fail!")
    
}

//2. 클로저의 경량 문법
//2-1. 파라미터 형식과 리턴 형식을 생략할 수 있다.
func doSomething5(closure: (Int, Int, Int) -> Int){
    closure(1, 2, 3)
}

doSomething5(closure: {(a: Int, b:Int, c:Int) -> Int in
    return a + b + c
})
//이것들은 다음과 같이 생략해서 쓸 수 있다.
doSomething5(closure: {(a, b, c) in
    return a + b + c
})

//2-2. Parmeter Name은 Shorthand Argument Names으로 대체하고, 이 경우 Parameter Name과 in 키워드를 삭제한다.
doSomething5(closure: {
    return $0 + $1 + $2
})
//2-3. 단일 리턴문만 남을 경우, return도 생략한다.
doSomething5(closure:{
    $0 + $1 + $2
})

//2-4. 클로저 파라미터가 마지막 파라미터라면, 트레일링 클로저로 작성한다.
doSomething5() {
    $0 + $1 + $2
}

//2-5. ()에 값이 아무것도 없다면 생략한다.
doSomething5 {
    $0 + $1 + $2
}

//3. @autoclosure
// 파라미터로 전달된 일반 구문 & 함수를 클로저로 래핑하는 것
func doSomething6(closure: @autoclosure () -> (Bool)){
        closure()
}
doSomething6(closure: 1 < 2)

//3-1. autoclosure 특징: 지연된 실행

//4. @escaping
//non-escaping Closure는 함수 내부에서 직접 실행하기 위해서만 사용한다.따라서 파라미터로 받은 클로저를 변수나 상수에 대입할 수 없고, 중첩 함수에서 클로저를 사용할 경우, 중첩함수를 리턴할 수 없다. 함수의 실행 흐름을 탈출하지 않아, 함수가 종료되기 전에 무조건 실행 되어야 한다.
// 함수 실행을 벗어나서 함수가 끝난 후에도 클로저를 실행하거나, 중첩함수에서 실행 후 중첩 함수를 리턴하고 싶거나, 변수 상수에 대입하고 싶은 경우 @escaping 키워드를 사용한다.
func domSomething7(closure: @escaping () -> ()){
    let f : () -> () = closure
}

func doSomething8(closure: @escaping () -> ()){
    print("function start")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 10){
        closure()
    }
    print("function end")
}
doSomething8 {print("closure") }
//##################################


