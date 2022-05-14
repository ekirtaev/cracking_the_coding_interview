//
//  Sort&SearchTests.swift
//  tests
//
//  Created by Евгений Киртаев on 25.04.2022.
//

import XCTest

class Sort_SearchTests: XCTestCase {

  //10.1
  func testMergeWithSort() {
    
    //given
    var input = [Int]()
    input.reserveCapacity(8)
    input += [0, 5, 7, 10, 15]
    let other = [1, 8, 11]
    
    //when
    input.mergeWithSort(other)
    let expected = [0, 1, 5, 7, 8, 10, 11, 15]
    
    //then
    XCTAssertEqual(input, expected)
  }
  
  //10.2
  
  func testSortAnagrams() {
    
    //given
    let input = ["cat", "tic", "tac", "abc", "cit", "itc"]
    
    //when
    let result = input.sortAnagrams(input)
    let expected = ["cat", "tac", "tic", "cit", "itc", "abc"]
    
    //then
    XCTAssertEqual(result, expected)
  }
  
  func testSortAnagramsWithComparator() {
    
    //given
    let input = ["cat", "tic", "tac", "abc", "cit", "itc"]
    
    //when
    let result = input.sortAnagramsWithComparator(input)
    let expected = ["tic", "cit", "itc", "cat", "tac", "abc"]
    
    //then
    XCTAssertEqual(result, expected)
  }

}
