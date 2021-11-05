//
//  DictionaryLocalService.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import PromiseKit

class DictionaryLocalServiceSingletone: DictionaryService {
  static let shared = DictionaryLocalServiceSingletone()
  
  private init() {}
  
  func search(word: String) -> Promise<[Word]> {
    return Promise { seal in
      if let data = UserDefaults.standard.data(forKey: "words"),
         let words = try? JSONDecoder().decode([Word].self, from: data) {
        let filterdWords = words.filter({ $0.word?.lowercased() == word.lowercased() })
        seal.fulfill(filterdWords)
      } else {
        seal.reject(DictionaryServiceError.noSuchWord)
      }
    }
  }
  
  func save(word: Word) {
    var words: [Word]
    if let data = UserDefaults.standard.data(forKey: "words"),
       let storedWords = try? JSONDecoder().decode([Word].self, from: data) {
      words = storedWords
    } else {
      words = []
    }
    
    if !words.contains(where: { $0.word == word.word }) {
      words.append(word)
    }
    
    if let data = try? JSONEncoder().encode(words) {
      UserDefaults.standard.set(data, forKey: "words")
    }
  }
}
