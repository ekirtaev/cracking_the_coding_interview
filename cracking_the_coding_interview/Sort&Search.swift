//
//  Sort&Search.swift
//  cracking_the_coding_interview
//
//  Created by Евгений Киртаев on 25.04.2022.
//

import Foundation

//10.1

extension Array where Element: Comparable {
  
  mutating func mergeWithSort(_ other: [Element]) {
    
    var a = 0
    var b = 0
    
    while a < self.capacity && b < other.count {
      if self[a] > other[b] {
        self.insert(other[b], at: a)
        b += 1
      } else {
        a += 1
      }
    }
  }
}

//10.2

extension Array {
  
  func sortAnagrams(_ anagrams: [String]) -> [String] {
      
    var matches = [String : [String]]()
    var result = [String]()
    
    for anagram in anagrams {
      var characters = [Character: Int]()
      var resultString = ""
      for character in anagram {
        characters[character] = (characters[character] ?? 0) + 1
      }
      for char in characters.keys.sorted() {
        resultString += "\(char)\(characters[char]!)"
      }
      if matches[resultString] != nil {
        var array = matches[resultString]
        array?.append(anagram)
        matches[resultString] = array
      } else {
        matches[resultString] = [anagram]
      }
    }
    
    for key in matches.keys {
      result += matches[key]!
    }
    
    return result
  }
  
  func sortAnagramsWithComparator(_ anagrams: [String]) -> [String] where Self.Element == String {
    
    let result = self.sorted { first, second in
      return first.sortChars() > second.sortChars()
    }
    
    return result
  }
}

extension String {

  func sortChars() -> String {
    
    let chars = Array(self).sorted()
    return String(chars)
  }
}
