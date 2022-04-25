//
//  LinkedList.swift
//  cracking_the_coding_interview
//
//  Created by Евгений Киртаев on 31.03.2022.
//

import Foundation
import CloudKit
import Metal

public struct LinkedList<Element: Hashable & Equatable> {
  
  public class Node<Element: Hashable & Equatable> {
    public var next: Node?
    public var data: Element
    
    init(_ data: Element) {
      self.data = data
    }
  }
  
  public var head: Node<Element>?
  
  //MARK: init
  
  init() { }
  
  init(_ head: Node<Element>) {
    self.head = head
  }
  
  init<S: Sequence>(_ sequence: S) where
    S.Iterator.Element == Element {
    for element in sequence {
      appendToTail(element)
    }
  }
  
  //MARK: public
  
  mutating func appendToTail(_ data: Element) {
    let node = Node(data)
    self.appendToTail(node)
  }
  
  mutating func appendToTail(_ node: Node<Element>) {
    var tail: Node<Element>
    if let head = self.head {
      tail = head
      while tail.next != nil {
        tail = tail.next!
      }
      tail.next = node
    } else {
      self.head = node
    }
  }
  
  mutating func insertToHead(_ data: Element) {
    let newHead = Node(data)
    if let head = self.head {
      newHead.next = head
    }
    self.head = newHead
  }
  
  mutating func removeFirst() -> Element? {
    if let head = self.head {
      let data = head.data
      self.head = head.next
      return data
    }
    return nil
  }
  
  func isEmpty() -> Bool {
    return (self.head == nil)
  }
  
}

extension LinkedList: ExpressibleByArrayLiteral {
  
  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }
  
  public init(array: [Element]) {
    self.init(array)
  }
}

extension LinkedList: Sequence {
  public func makeIterator() -> LinkedListIterator<Element> {
    return LinkedListIterator(list: self)
  }
  
  public typealias Iterator = LinkedListIterator<Element>

}

public struct LinkedListIterator<Element: Hashable & Equatable>: IteratorProtocol {
  
  private var list: LinkedList<Element>
  
  init(list: LinkedList<Element>) {
    self.list = list
  }
  
  public mutating func next() -> Element? {
    defer {
      if !self.list.isEmpty() { self.list.removeFirst() }
    }

    return self.list.head?.data
  }
}

extension LinkedList: Equatable {

  public static func == (lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
    return lhs.elementsEqual(rhs)
  }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
      if let head = self.head {
        return head.description
      }
      return "nil"
    }
}

extension LinkedList.Node: CustomStringConvertible {
  
  public var description: String {
    var description = "\(data)"
    if let next = self.next {
       description += ( " -> " + next.description)
    }
    return description
  }
}
