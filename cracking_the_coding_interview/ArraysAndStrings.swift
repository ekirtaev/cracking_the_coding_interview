//
//  ArraysAndStrings.swift
//  cracking_the_coding_interview
//
//  Created by Евгений Киртаев on 01.02.2022.
//

import Foundation

//1.1

func hasUniqueCharacters(string: String) -> Bool {
  
  for (i, first) in string.enumerated() {
    for (j, second) in string.enumerated() {
      if first == second && i != j {
        return false
      }
    }
  }
  return true
}

//1.2

func checkPermutation(first: String, second: String) -> Bool {
  
  if first.count == second.count {
    var firstHash: [Character: Int] = [Character: Int]()
    var secondHash: [Character: Int] = [Character: Int]()
    
    for i in 0..<firstHash.count {
      
      let index = first.index(first.startIndex, offsetBy: i)
      
      let firstItem = first[index]
      var firstValue: Int? = firstHash[firstItem]
      firstValue = firstValue != nil ? firstValue! + 1 : 1
      firstHash[firstItem] = firstValue
      
      let secondItem = second[index]
      var secondValue: Int? = secondHash[secondItem]
      secondValue = secondValue != nil ? secondValue! + 1 : 1
      secondHash[firstItem] = secondValue
    }
    
    for (key, value) in firstHash {
      if let secondValue = secondHash[key] {
        if secondValue != value {
          return false
        }
      } else {
        return false
      }
    }
    
  } else {
    return false
  }
  
  return true
}

//1.3

extension String {
  
  func urlify() -> String {
    
    var result: String = ""
    for character in self {
      if character == " " {
        result += "%20"
      } else {
        result.append(character)
      }
    }
    
    return result
  }
  
}

//1.4

extension String {
  
  func isPalindromPermutation() -> Bool {
    
    var hash = [Character: Int]()
    var result = true
    let tmpSelf = self.lowercased()
    
    for index in tmpSelf.indices {
      let character = tmpSelf[index]
      if character != " " {
        hash[character] = (hash[character] ?? 0) + 1
      }
    }
    
    //check if palindrom
    var middleCharacter: Character?
    for (key, value) in hash {
      if value % 2 != 0 {
        if middleCharacter == nil {
          middleCharacter = key
        } else {
          result = false
          break
        }
      }
    }
    
    //generate combos
    if result == true {
      var resultSentences = [String]()
      if let middleKey = middleCharacter {
        hash.removeValue(forKey: middleKey)
      }
      let chars = Array(hash.keys)
      let combos = getCombos(characters: chars)
      for combo in combos {
        var string = combo
        if middleCharacter != nil {
          string.append(middleCharacter!)
        }
        string += combo.reversed()
        resultSentences.append(string)
      }
      print(resultSentences)
    }
    
    return result
  }
  
}

func getCombos(characters: [Character]) -> [String] {
  var combos = [String]()
  if characters.count == 1 {
    return [String(characters.first!)]
  } else {
    var mCharacters = characters
    let lastChar = mCharacters.removeLast()
    for combo in getCombos(characters: mCharacters) {
      for index in combo.indices {
        var mString = combo
        mString.insert(lastChar, at: index)
        combos.append(mString)
      }
      var mString = combo
      mString.insert(lastChar, at: mString.endIndex)
      combos.append(mString)
    }
  }
  return combos
}

//1.5

extension String {
  
  func isOnOneWay(other: String) -> Bool {
    var result = true
    
    let isReplacement = self.count == other.count ? true : false
    let isAdding = other.count - self.count == 1 ? true : false
    let isRemoving = self.count - other.count == 1 ? true : false
    
    var changes: Int = 0
    
    if isReplacement {
      for index in self.indices {
        let selfChar = self[index]
        if other.indices.contains(index) {
          let otherChar = other[index]
          if selfChar != otherChar {
            changes += 1
          }
          if changes > 1 {
            result = false
            break
          }
        }
      }
    }
    
    var lastChar: Character?
    var shortest: String
    var longest: String
    if isAdding {
      shortest = self
      longest = other
    } else {
      shortest = other
      longest = self
    }
    
    if isRemoving || isAdding {
      for index in shortest.indices {
        let selfChar = shortest[index]
        if longest.indices.contains(index) {
          let otherChar = longest[index]
          if selfChar != otherChar && otherChar != lastChar {
            changes += 1
          }
          lastChar = selfChar
          if changes > 1 {
            result = false
            break
          }
        }
      }
    }

    return result
  }
  
}

//1.6

extension String {
  
  func compressIfNeeded() -> String {
    
    var result: String = ""
    
    var lastChar: Character?
    var sequenceLength: Int = 0
    
    for index in self.indices {
      let char = self[index]
      if lastChar != char && lastChar != nil {
        result += String(lastChar!)
        result += String(sequenceLength)
        sequenceLength = 0
      }
      sequenceLength += 1
      lastChar = char
    }
    if lastChar != nil {
      result += String(lastChar!)
      result += String(sequenceLength)
    }

    return result.count < self.count ? result : self
  }
}

//1.7

func rotateMatrix<T>(matrix: [[T]]) -> [[T]] {
  
  func getNewCoordinatesFrom(coordinates: (x: Int, y: Int),  matrixSize: Int) -> (x: Int, y: Int) {
    let newX = coordinates.y
    let newY = (matrixSize - 1 - coordinates.x)
    return (newX, newY)
  }
  
  var resultMatrix: [[T]] = matrix
  let limit: Int
  if matrix.count % 2 == 0 {
    limit = matrix.count/2
  } else {
    limit = matrix.count/2 + 1
  }
  
  for i in 0..<limit {
    for j in 0..<limit {
      var valueToSwap = matrix[i][j]
      var lastCoordinates: (Int, Int) = (i, j)
      repeat {
        lastCoordinates = getNewCoordinatesFrom(coordinates: (lastCoordinates.0, lastCoordinates.1), matrixSize: matrix.count)
        let value = matrix[lastCoordinates.0][lastCoordinates.1]
        resultMatrix[lastCoordinates.0][lastCoordinates.1] = valueToSwap
        valueToSwap = value
      } while lastCoordinates != (i, j)
      
    }
  }
  
  return resultMatrix
}

//1.8

func makeZeroMatrix(from: [[Int]]) -> [[Int]] {
  
  var zeroRows: [Int] = [Int]()
  var zeroColumns: [Int] = [Int]()
  var result = from
  
  for rowIndex in result.indices {
    if !zeroRows.contains(rowIndex) {
      for columnIndex in result[rowIndex].indices {
        if !zeroColumns.contains(columnIndex) {
          if result[rowIndex][columnIndex] == 0 {
            zeroRows.append(rowIndex)
            zeroColumns.append(columnIndex)
          }
        }
      }
    }
  }
  
  for rowIndex in result.indices {
    for columnIndex in result[rowIndex].indices {
      if zeroRows.contains(rowIndex) || zeroColumns.contains(columnIndex) {
        result[rowIndex][columnIndex] = 0
      }
    }
  }
  
  return result
}

//1.9

extension String {
  
  func isRotation(of other: String) -> Bool {
    
    var mSelf = self
    for index in self.indices {
      let char = self[index]
      mSelf.remove(at: mSelf.startIndex)
      mSelf.append(char)
      if mSelf == other {
        return true
      }
    }
    return false
  }
}

