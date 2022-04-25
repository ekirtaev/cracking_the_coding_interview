//
//  Stack.swift
//  cracking_the_coding_interview
//
//  Created by Евгений Киртаев on 06.04.2022.
//

import Foundation

public struct Stack<Element> {

  private var elements: [Element] = [Element]()
}

public extension Stack {
  
  mutating func push(_ element: Element) {
    self.elements.append(element)
  }
  
  mutating func pop() -> Element? {
    return self.elements.removeLast()
  }
  
  func count() -> Int {
    return self.elements.count
  }
  
  func isEmpty() -> Bool {
    return self.count() == 0
  }
  
  func peek() -> Element? {
    return self.elements.last
  }
  
  mutating func bottom() -> Element? {
    
    guard !self.isEmpty() else { return nil }
    return self.elements.removeFirst()
  }
}

extension Stack: CustomStringConvertible {
  
  public var description: String {
    return self.elements.reversed().description
  }
}

extension Stack: Equatable where Element: Equatable {
  
  public static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool {
    
    guard lhs.count() == rhs.count() else { return false }
    for _ in 0..<lhs.count() {
      var mLhs = lhs
      var mRhs = rhs
      if mLhs.pop() != mRhs.pop() {
        return false
      }
    }
    
    return true
  }
}
