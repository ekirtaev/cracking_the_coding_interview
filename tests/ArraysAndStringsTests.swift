//
//  ArraysAndStringsTests.swift
//  tests
//
//  Created by Евгений Киртаев on 01.02.2022.
//

import XCTest

class ArraysAndStringsTests: XCTestCase {

  //1.1
  
  func testUniqueCharactersInString() {
    //given
    let input = "117"
    let expectedResult = false
    
    //when
    let result = hasUniqueCharacters(string: input)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.2
  
  func testCheckPermutation() {
    //given
    let inputFirst = "1173312"
    let inputSecond = "1713123"

    let expectedResult = true
    
    //when
    let result = checkPermutation(first: inputFirst, second: inputSecond)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.3
  
  func testUrlify() {
    //given
    let input = "Mr John Smith"

    let expectedResult = "Mr%20John%20Smith"
    
    //when
    let result = input.urlify()
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.4
  
  func testPalindromPermutation() {
    //given
    let input = "Tact Coa"

    let expectedResult = true
    
    //when
    let result = input.isPalindromPermutation()
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.5
  
  func testOneWay() {
    //given
    let firstInput = "pale"
    let secondInput = "bake"
    
    let expectedResult = false
    
    //when
    let result = firstInput.isOnOneWay(other: secondInput)
    //then
    XCTAssertEqual(expectedResult, result)
  }

  //1.6
  
  func testStringCompressing() {
    //given
    let input = "aabcccccaaa"
    let expectedResult = "a2b1c5a3"
        
    //when
    let result = input.compressIfNeeded()
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.7
  
  func testMatrixRotate() {
    //given
    let input = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
    let expectedResult = [[13, 9, 5, 1], [14, 10, 6, 2], [15, 11, 7, 3], [16, 12, 8, 4]]
        
    //when
    let result = rotateMatrix(matrix: input)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.8
  
  func testZeroMatrix() {
    //given
    let input = [[1, 0, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]]
    let expectedResult = [[0, 0, 0, 0], [5, 0, 7, 0], [9, 0, 11, 0], [0, 0, 0, 0]]
        
    //when
    let result = makeZeroMatrix(from: input)
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //1.9
  func testStringRotation() {
    //given
    let inputFirst = "waterbottle"
    let inputSecond = "erbottlewat"
    let expectedResult = true
        
    //when
    let result = inputFirst.isRotation(of: inputSecond)
    //then
    XCTAssertEqual(expectedResult, result)
  }
}
