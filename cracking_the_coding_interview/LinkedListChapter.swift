//
//  LinkedList.swift
//  cracking_the_coding_interview
//
//  Created by Евгений Киртаев on 03.02.2022.
//

import Foundation


//2.1

extension LinkedList {
  
  func removeDublicates() -> LinkedList {
    
    var result = LinkedList<Element>()
    var unique = Set<Element>()

    if !self.isEmpty() {
      var tmpNode = self.head
      while tmpNode != nil {
        let data = tmpNode!.data
        if !unique.contains(data) {
          unique.insert(data)
          result.appendToTail(data)
        }
        tmpNode = tmpNode?.next
      }
    }
    
    return result
  }
  
  func removeDublicatesWithoutBuffer() {
    if let head = self.head, let next = self.head?.next {
      var current: Node? = head
      var runner: Node? = next
      while current != nil {
        var previous: Node = current!
        while runner != nil {
          if current!.data == runner!.data {
            previous.next = runner!.next
          } else {
            previous = runner!
          }
          runner = runner!.next
        }
        current = current!.next
      }
    }
  }
  
}

//2.2

extension LinkedList {
  
  func kthToLastElement(_ index: Int) -> Element? {
    var result: Element?
    var reversed = LinkedList()
    if let head = self.head {
      var tmp: Node? = head
      while tmp != nil {
        reversed.insertToHead(tmp!.data)
        tmp = tmp!.next
      }
      print(reversed)
      var count = 0
      var currentNode: Node? = reversed.head
      while currentNode != nil {
        if count == index {
          result = currentNode?.data
          break
        }
        currentNode = currentNode?.next
        count += 1
      }
    }
    return result
  }
  
  func kthToLastElement2(_ index: Int) -> Element? {
    var result: Element?
    
    if let head = self.head {
      var last: Node? = head
      var kth: Node<Element>?
      var counter: Int = 0
      while last != nil {
        if counter == index {
          kth = head
        } else if counter > index {
          kth = kth?.next
        }
        counter += 1
        last = last?.next
      }
      if let resultNode = kth {
        result = resultNode.data
      }
    }
    
    return result
  }
  
  func kthToLastElement3(_ k: Int) -> Element? {
    let result = self.kthToLastElementWithHead(self.head, k)
    return result.value
  }
  
  func kthToLastElementWithHead(_ head: Node<Element>?, _ k: Int) -> (index: Int, value: Element?) {
    
    if head == nil {
      return (-1, nil)
    }
    
    let tuple = self.kthToLastElementWithHead(head!.next, k)
    let index = tuple.index + 1
    
    var result: Element?
    
    if tuple.value != nil {
      return tuple
    } else {
      if index == k {
        result = head!.data
      }
    }
    
    return (index, result)
  }

}

//2.3

extension LinkedList {
  
  func removeKthNode(_ node: Node<Element>?) {
    if let next = node?.next {
      node!.data = next.data
      node!.next = next
    }
  }
}

//2.4

extension LinkedList where Element: Comparable {
  
  func partition(_ value: Element) -> LinkedList {
    
    var result: LinkedList = LinkedList()
    var firstPart: Node<Element>
    var secondPart: Node<Element>
    
    if let head = self.head, self.head?.next != nil {
      firstPart = head
      secondPart = head
      var node: Node? = head.next
      
      while node != nil {
        let next = node!.next
        if node!.data < value {
          node!.next = firstPart
          firstPart = node!
        } else {
          secondPart.next = node
          secondPart = node!
        }
        node = next
      }
      secondPart.next = nil
      result.head = firstPart
    }
    
    print(result)
    return result
  }
 
}

//2.5

extension LinkedList {
  
  static func sum(_ first: LinkedList<Element>, _ second: LinkedList<Element>) -> LinkedList where Element == Int {
    
    var result: LinkedList = LinkedList()
    
    if let firstHead = first.head, let secondHead = second.head {
      var firstListNode: Node? = firstHead
      var secondListNode: Node? = secondHead
      var rank = 0
      while firstListNode != nil || secondListNode != nil {
        var sum = firstListNode != nil ? secondListNode != nil ? firstListNode!.data + secondListNode!.data : firstListNode!.data : secondListNode!.data
        sum += rank
        let res = sum.quotientAndRemainder(dividingBy: 10)
        rank = res.quotient
        result.appendToTail(res.remainder)
        firstListNode = firstListNode?.next
        secondListNode = secondListNode?.next
      }
    }
    
    return result
  }
  
}

//2.6

extension LinkedList {
  
  func isPalindrome() -> Bool {
    
    var reversed = LinkedList()
    if let head = self.head {
      var tmp: Node? = head
      while tmp != nil {
        reversed.insertToHead(tmp!.data)
        tmp = tmp!.next
      }
      return self == reversed
    }
    
    return false
  }
  
  func isPalindrome1() -> Bool {
    
    if let head = self.head {
      var stack: Stack = Stack<Element>()
      var slow: Node? = head
      var fast: Node? = head
      
      while fast != nil && fast?.next != nil {
        stack.push(slow!.data)
        slow = slow!.next
        fast = fast!.next?.next
      }
      
      if fast != nil {
        slow = slow?.next
      }
      
      while slow != nil {
        let valueFromStack = stack.pop()
        let valueFromList = slow?.data
        if valueFromList != valueFromStack {
          return false
        }
        slow = slow?.next
      }
      
      return true
    }

    return false
  }
}

//2.7

extension LinkedList {
  
  static func intersect(_ first: LinkedList, _ second: LinkedList) -> Node<Element>? {
        
    var result: Node<Element>?
    
    if first.head == nil || second.head == nil {
      return nil
    }
    
    let tailAndSize1 = first.getTailAndSize()
    let tailAndSize2 = second.getTailAndSize()
    
    let short = tailAndSize1.size < tailAndSize2.size ? first : second
    let long = tailAndSize2.size < tailAndSize1.size ? first : second
    
    var shortHead = short.head
    var longHead = long.getKthNode(abs(tailAndSize1.size - tailAndSize2.size))
    
    while shortHead !== longHead {
      shortHead = shortHead?.next
      longHead = longHead?.next
    }
    
    if shortHead != nil {
      result = shortHead
    }
        
    return result
  }
  
  func getTailAndSize() -> (tail: Node<Element>?, size: Int) {
    
    var size: Int = 0
    var tail: Node<Element>? = self.head
    
    while tail?.next != nil {
      size += 1
      tail = tail?.next
    }
    
    return (tail, size)
  }
  
  func getKthNode(_ k: Int) -> Node<Element>? {
    
    var result: Node<Element>?
    if let head = self.head {
      var count = 0
      var node: Node? = head
      while count < k {
        node = node?.next
        count += 1
      }
      if count == k {
        result = node
      }
    }
    return result
  }
}

//2.8

extension LinkedList {
  
  func getLoopNode() -> Node<Element>? {
    
    var result: Node<Element>?
    
    if let head = self.head {
      var slow: Node? = self.head
      var fast: Node? = self.head
      
      while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast {
          break
        }
      }
      
      if fast == nil || fast?.next == nil {
        return result
      }
      
      slow = head
      while slow !== fast {
        slow = slow?.next
        fast = fast?.next
      }
      result = slow
    }

    return result
  }
}
