//
//  LinkedListTests.swift
//  tests
//
//  Created by Евгений Киртаев on 03.02.2022.
//

import XCTest

class LinkedListTests: XCTestCase {

  //2.1
  func testRemoveDublicates() {
    //given
//    let input: LinkedList = [1, 2, 3, 1, 4]
//    let expectedResult: LinkedList = [1, 2, 3, 4]
    
    let input: LinkedList = ["a", "b", "c", "a", "d"]
    print(input)
    let expectedResult: LinkedList = ["a","b", "c", "d"]
    print(expectedResult)
    
    //when
    let result = input.removeDublicates()
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  func testRemoveDublicatesWhitoutDublicates() {
    //given
//    let input: LinkedList = [1, 2, 3, 1, 4]
//    let expectedResult: LinkedList = [1, 2, 3, 4]
    
    let input: LinkedList = ["a", "b", "c", "a", "d"]
    print(input)
    let expectedResult: LinkedList = ["a","b", "c", "d"]
    print(expectedResult)
    
    //when
    input.removeDublicatesWithoutBuffer()
    //then
    XCTAssertEqual(expectedResult, input)
  }
  
  //2.2
  
  func testKthToLastElement() {
    //given
//    let input: LinkedList = [1, 2, 3, 1, 4]
//    let expectedResult: LinkedList = [1, 2, 3, 4]
    
    let input: LinkedList = ["a", "b", "c", "a", "d"]
    print(input)
    let expectedResult = "c"
    print(expectedResult)
    
    //when
    let result = input.kthToLastElement(2)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  func testKthToLastElement2() {
    //given
//    let input: LinkedList = [1, 2, 3, 1, 4]
//    let expectedResult: LinkedList = [1, 2, 3, 4]
    
    let input: LinkedList = ["a", "b", "c", "a", "d"]
    print(input)
    let expectedResult = "c"
    print(expectedResult)
    
    //when
    let result = input.kthToLastElement2(2)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  func testKthToLastElement3() {
    //given
//    let input: LinkedList = [1, 2, 3, 1, 4]
//    let expectedResult: LinkedList = [1, 2, 3, 4]
    
    let input: LinkedList = ["a", "b", "c", "a", "d"]
    print(input)
    let expectedResult = "c"
    print(expectedResult)
    
    //when
    let result = input.kthToLastElement3(2)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //2.4
  
  func testPartition() {
    //given
    let input: LinkedList = [3, 5, 8, 5, 10, 2, 1]
    let expectedResult: LinkedList = [1, 2, 3, 5, 8, 5, 10]
    
    print(input)
    print(expectedResult)
    
    //when
    let result = input.partition(5)
    
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //2.5
  
  func testSum() {
    //given
    let input1: LinkedList = [7, 1, 6]
    let input2: LinkedList = [5, 9, 2]

    let expectedResult: LinkedList = [2, 1, 9]
    
    print(input1)
    print(input2)
    print(expectedResult)
    
    //when
    let result = LinkedList.sum(input1, input2)
    
    //then
    XCTAssertEqual(expectedResult, result)
  }

  //2.6
  
  func testPalindrome() {
    //given
    let chars = "tacocat".reduce(into: []) { $0.append($1) }
    let input = LinkedList(array: chars)
    let expectedResult = true
    
    //when
    let result = input.isPalindrome()
    
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  func testPalindrome1() {
    //given
    let chars = "tacocat".reduce(into: []) { $0.append($1) }
    let input = LinkedList(array: chars)
    let expectedResult = true
    
    //when
    let result = input.isPalindrome1()
    
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //2.7
  
  func testIntersect() {
    //given
    var input1: LinkedList = ["a", "b"]
    var input2: LinkedList = ["f"]
    let common: LinkedList.Node = LinkedList<String>.Node("c")
    common.next = LinkedList.Node<String>("d")
    input1.appendToTail(common)
    input2.appendToTail(common)
    
    print(input1)
    print(input2)
    
    let expectedResult = common
    
    //when
    let result = LinkedList.intersect(input1, input2)
    
    //then
    XCTAssertTrue(result === expectedResult)
  }
  
  //2.8
  
  func testGetLoopNode() {
    //given
    var input: LinkedList = ["a", "b"]
    let loopNode: LinkedList.Node = LinkedList<String>.Node("c")
    input.appendToTail(loopNode)
    var loop : LinkedList = ["d", "e"]
    loop.appendToTail(loopNode)
    input.appendToTail(loop.head!)
    
    let expectedResult = loopNode
    
    //when
    let result = input.getLoopNode()
    
    //then
    XCTAssertTrue(result === expectedResult)
  }

}
