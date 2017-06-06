//: Playground - noun: a place where people can play

import UIKit
// https://robots.thoughtbot.com/introduction-to-function-currying-in-swift
// Currying refers to A function that takes multiple arguments into evaluating a sequence of functions, each with a single argument

/* 
 func addTwo(x: Int) -> Int {
 return x + 2
 }
 
 func addTen(x: Int) -> Int {
 return x + 10
 }
 
 func addTogether(x: Int, y: Int) -> Int {
 return x + y
 }
 
 addTwo(x: 4)
 addTen(x: 10)*/
// -----------------------------
let num: Int = 5
let hello: String = "Hello"

// Different ways to declare a function
let square: (Int) -> Int = { $0 * $0 }

let sameSquare = { (x: Int) -> Int in
    return x * x
}

func squareFunc(x: Int) -> Int {
    return x * x
}

let squareFuncVar = squareFunc
square(4)
squareFuncVar(5)

// expected to return a func that takes an Int and returns an Int
func squareFuncReturningFunc() -> ((Int) -> Int) {
    
    // (Int) -> Int is this function's type
    func squareFunc(x: Int) -> Int {
        return x * x
    }
    
    return squareFunc
}

let squaringFunc = squareFuncReturningFunc()
squaringFunc(4)

// -----------------------------
// operator are function
// + (a: Int, b: Int) -> Int
// [1, 2, 3, 4].reduce(0, +)

typealias IntFunction = (Int) -> Int // renaming the value
// typealias AnythignWeWant = Int

func addA(x: Int) -> IntFunction {
    
    func addB(y: Int) -> Int {
        return x + y
    }
    
    return addB
}

// addTwo here is a function of (Int) -> Int
// addA returns addB(y:) with a knowledge of x as 2
let addTwo = addA(x: 2)
let answer = addTwo(5)

let addFive = addA(x: 5)
let answer2 = addFive(5)
let answer3 = addFive(10)
// addGFive is runnign a closure where
// { (y: Int) in
//      return $0 + y
// }

// -----------------------------

func addY(a: Int) -> IntFunction {
    // All three of these are returning a function/closure that takes an Int and return an Int
    
    //     func addX(b: Int) -> Int {
    //        return a + b
    //     }
    //     return addX
    
    //    return { (b: Int) -> Int in
    //        return a + b
    //    }
    
    return { a + $0 }
    // return { b in a + b }
}
let addSix = addY(a: 6)
addSix(7)

// ----------------------------
var arrayNum = [1, 2, 3, 4, 5, 6]
let ans = arrayNum.map{ squareFunc(x: $0) }
print(ans)

// ----------------------------
class Car {
    var speed: Int = 0
    
    func accelerateBy(factor: Int) -> Int {
        speed += factor
        return speed
    }
}

let car1 = Car()
let car2 = Car()
print(car1.accelerateBy(factor: 10))

Car.accelerateBy(car1)(factor: 20)
print(car1.speed)

let car2Accel = Car.accelerateBy(car2)
car2Accel(10)
car2Accel(20)
car2Accel(30)
car2Accel(-60)

// ----------------------------
struct Cat {
    var food: String = "Fish"
    
    mutating func updateFood(food: String) -> String {
        self.food = food
        return self.food
    }
}

var cat1 = Cat()
var cat1Food = Cat.updateFood(&cat1)(food: "Fishball")
