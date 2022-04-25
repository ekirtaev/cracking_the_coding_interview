//
//  StacksAndQueues.swift
//  cracking_the_coding_interview
//
//  Created by Евгений Киртаев on 08.04.2022.
//

import Foundation
import CloudKit


//1.1

struct MultiStack<Element> {
  
  var values: [Element?] = [Element?]()
  var stackInfo = [StackInfo]()
  var capacity: Int = 0
  
  init(_ numberOfStacks: Int, _ capacity: Int) {
    guard numberOfStacks > 0 && capacity > 0 else { return }
    self.capacity = capacity
    for _ in 0..<numberOfStacks {
      self.stackInfo.append(StackInfo(capacity: capacity))
    }
    self.values = Array(repeating: nil, count: capacity * numberOfStacks)
  }
  
  private func stackDescription(_ stackIndex: Int) -> String? {
    
    guard stackIndex < self.stackInfo.count && stackIndex >= 0 else { return nil }
    var stackInfo: StackInfo = self.stackInfo[stackIndex]
    if stackInfo.isEmpty() {
      return ""
    } else {
      var s = ""
      while !stackInfo.isEmpty() {
        let index = stackIndex + (max(0, stackInfo.count - 1)) * self.stackInfo.count
        let element = self.values[index]
        s += "\(element)"
        stackInfo.count -= 1
      }
      return s
    }
  }
}

extension MultiStack {
  
  mutating func push(_ element: Element, _ stackIndex: Int) {
    
    guard stackIndex < self.stackInfo.count && stackIndex >= 0 else { return }
    
    var stackInfo = self.stackInfo[stackIndex]
    let currentIndex = stackIndex + stackInfo.count * self.stackInfo.count
    self.values[currentIndex] = element
    stackInfo.count += 1
    self.stackInfo[stackIndex] = stackInfo
  }
  
  mutating func pop(_ stackIndex: Int) -> Element? {
    
    guard stackIndex < self.stackInfo.count && stackIndex >= 0 else { return nil }
    var stackInfo = self.stackInfo[stackIndex]
    if stackInfo.isEmpty() {
      return nil
    }
    
    let lastIndex = stackIndex + (max(0, stackInfo.count - 1)) * self.stackInfo.count
    var element: Element?
    if lastIndex < self.values.count {
      element = self.values[lastIndex]
      self.values[lastIndex] = nil
      stackInfo.count -= 1
      self.stackInfo[stackIndex] = stackInfo
    }
    
    return element
  }
  
  func isEmpty() -> Bool {
    return self.stackInfo.reduce(into: true) { $0 = $0 && $1.isEmpty() }
  }
}

struct StackInfo {
  
  var count: Int = 0
  var capacity: Int
  
  func isEmpty() -> Bool {
    return self.count == 0
  }
}

extension MultiStack: CustomStringConvertible {
  
  var description: String {
    var s = ""
    for i in 0..<self.stackInfo.count {
      s += "stack \(i):"
      if let stackDescription = self.stackDescription(i) {
        s += "\(stackDescription)\n"
      }
    }
    return s
  }
}


//3.3

struct SetOfStacks<Element> {
  
  private var stacks: [Stack] = [Stack<Element>]()
  private var capacity: Int
  
  init(_ capacity: Int) {
    self.capacity = capacity
  }
  
  private mutating func leftShift(_ index: Int, _ removeTop: Bool) -> Element? {
    guard index < self.stacks.count else { return nil }
    
    var stack = self.stacks[index]
    let result: Element? = removeTop ? stack.pop() : stack.bottom()
    if stack.isEmpty() {
      self.stacks.remove(at: index)
    } else if self.stacks.count >= index + 1 {
      let bottom = self.leftShift(index + 1, false)
      stack.push(bottom!)
      self.stacks[index] = stack
    }
    
    return result
  }
}

extension SetOfStacks {
  
  mutating func push(_ element: Element) {
    
    var targetStack: Stack<Element>
    var stackIndex = max(0, self.stacks.count - 1)
    var replace = true
    
    if stackIndex < self.stacks.count {
      let lastStack = self.stacks[stackIndex]
      if lastStack.count() < self.capacity {
        targetStack = lastStack
      } else {
        stackIndex += 1
        targetStack = Stack()
        replace = false
      }
    } else {
      targetStack = Stack()
      replace = false
    }
    
    targetStack.push(element)
    if replace {
      self.stacks[stackIndex] = targetStack
    } else {
      self.stacks.append(targetStack)
    }
  }
  
  mutating func pop() -> Element? {
    
    if var last = self.stacks.last {
      let result = last.pop()
      if last.isEmpty() {
        self.stacks.removeLast()
      }
      return result
    }
    
    return nil
  }
  
  mutating func popAt(_ index: Int) -> Element? {
    return self.leftShift(index, true)
  }
  
  func count() -> Int {
    return self.stacks.reduce(0) { $0 + $1.count() }
  }
  
  func isEmpty() -> Bool {
    return self.stacks.count == 0
  }
}

//3.4

struct MyQueue<Element> {
  
  var inStack = Stack<Element>()
  var outStack = Stack<Element>()
}

extension MyQueue {
  
  mutating func enqueue(_ element: Element) {
    self.inStack.push(element)
  }
  
  mutating func dequeue() -> Element? {
    
    if self.outStack.isEmpty() {
      while let next = self.inStack.pop() {
        self.outStack.push(next)
      }
    }
   
    return outStack.pop()
  }
  
}

//3.5

extension Stack where Element: Comparable {
  
  func sort() -> Stack {
    
    var mSelf = self
    var result = Stack<Element>()
   
    while !mSelf.isEmpty() {
      if let temp = mSelf.pop() {
        while !result.isEmpty() {
          if temp > result.peek()! {
            mSelf.push(result.pop()!)
          } else {
            break
          }
        }
        result.push(temp)
      }
    }
    
    return result
  }
}

//3.6

//struct Queue<Element> {
//
//
//}
//
//extension Queue {
//
//  var count: Int {
//
//  }
//
//  mutating func push(_ element: Element) {
//
//  }
//
//  mutating func pop() -> Element? {
//
//  }
//
//  func isEmpty() -> Bool {
//
//  }
//
//  func peek() -> Element? {
//
//  }
//}

struct Animal {
  
  enum AnimalType: String {
    case cat = "cat"
    case dog = "dog"
  }
  
  var name: String
  var type: AnimalType
  var order: Int?
}

extension Animal: Hashable {
  
}

extension Animal: Equatable {
  
  static func == (lhs: Animal, rhs: Animal) -> Bool {
    if lhs.name == rhs.name && lhs.type == rhs.type {
      return true
    } else {
      return false
    }
  }
}

struct AnimalShelterQueue {

  private var count: Int = 0
  private var dogs: LinkedList = LinkedList<Animal>()
  private var cats: LinkedList = LinkedList<Animal>()
}

extension AnimalShelterQueue {

  mutating func enqueue(_ animal: Animal) {
    
    var tmpAnimal = animal
    tmpAnimal.order = self.count
    
    switch animal.type {
    case .cat:
      self.cats.appendToTail(animal)
    default:
      self.dogs.appendToTail(animal)
    }
  }

  mutating func dequeueAny() -> Animal? {
    
    if self.dogs.isEmpty() && self.cats.isEmpty() {
      return self.dogs.head!.data.order! > self.cats.head!.data.order! ? self.dequeueCat() : self.dequeueDog()
    } else if self.dogs.isEmpty() {
      return self.dequeueCat()
    } else {
      return self.dequeueDog()
    }
  }

  mutating func dequeueDog() -> Animal? {
    return self.dogs.removeFirst()
  }

  mutating func dequeueCat() -> Animal? {
    return self.cats.removeFirst()
  }
  
}
