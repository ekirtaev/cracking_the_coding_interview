//
//  StacksAndQueuesTests.swift
//  tests
//
//  Created by Евгений Киртаев on 08.04.2022.
//

import XCTest

class StacksAndQueuesTests: XCTestCase {
  
  //3.1
  func testMultiStack() {
    //given
    let elements = [10, 20, 30, 40]
    var multiStack: MultiStack = MultiStack<Int>(elements.count, 5)
    for i in 0..<elements.count {
      multiStack.push(elements[i], i)
    }

    //then
    multiStack.push(21, 1)
    multiStack.push(11, 0)
    multiStack.push(12, 0)
    print(multiStack)
    XCTAssertTrue(multiStack.pop(0) == 12)
    XCTAssertTrue(multiStack.pop(1) == 21)
    XCTAssertTrue(multiStack.pop(0) == 11)
  }
  
  //3.3
  func testSetOfStacks() {
    
    //given
    let elements = [10, 20, 30, 40]
    var input: SetOfStacks = SetOfStacks<Int>(3)
    for i in 0..<elements.count {
      input.push(elements[i])
    }
    print(input)

    //when
    let result = input.popAt(0)
    let expectedResult = 30
    
    //then
    XCTAssertEqual(expectedResult, result)
  }
  
  //3.5
  
  func testStackSort() {
    
    //given
    let elements = [12, 5, 8, 10, 1, 3, 7]
    var input = Stack<Int>()
    for i in 0..<elements.count {
      input.push(elements[i])
    }
    print(input)

    //when
    var expectedResult = Stack<Int>()
    for element in elements.sorted(by: { $0 > $1 } ) {
      expectedResult.push(element)
    }
    print(expectedResult)
    input = input.sort()
    print(input)

    //then
    XCTAssertEqual(input, expectedResult)
  }
  
  //3.6
  
  func testAnimalShelter() {
    
    //given
    let animals = [Animal(name: "Jack", type: Animal.AnimalType.dog),
                   Animal(name: "Tom", type: Animal.AnimalType.cat),
                   Animal(name: "Bethoven", type: Animal.AnimalType.dog),
                   Animal(name: "Leopold", type: Animal.AnimalType.cat),
                   Animal(name: "Snoopy", type: Animal.AnimalType.dog)]
    var input = AnimalShelterQueue()
    for i in 0..<animals.count {
      input.enqueue(animals[i])
    }
    print(input)

    //when
    let expectedCat = Animal(name: "Tom", type: Animal.AnimalType.cat)
    let expectedDog = Animal(name: "Jack", type: Animal.AnimalType.dog)
    let expectedWhatever = Animal(name: "Bethoven", type: Animal.AnimalType.dog)
    
    //then
    var animal: Animal? = input.dequeueCat()
    XCTAssertEqual(animal, expectedCat)
    animal = input.dequeueDog()
    XCTAssertEqual(animal, expectedDog)
    animal = input.dequeueAny()
    XCTAssertEqual(animal, expectedWhatever)
  }
}
