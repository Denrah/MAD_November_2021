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
    
    updateStat()
  }
  
  func savedWords() -> [Word] {
    if let data = UserDefaults.standard.data(forKey: "words"),
       let words = try? JSONDecoder().decode([Word].self, from: data) {
      return words
    } else {
      return []
    }
  }
  
  func savedWordsCount() -> Int {
    if let data = UserDefaults.standard.data(forKey: "words"),
       let words = try? JSONDecoder().decode([Word].self, from: data) {
      return words.count
    } else {
      return 0
    }
  }
  
  func getRates() -> [Rate] {
    if let data = UserDefaults.standard.data(forKey: "rates"),
       let rates = try? JSONDecoder().decode([Rate].self, from: data) {
      return rates
    } else {
      return []
    }
  }
  
  func saveRate(rate: Rate) {
    var rates: [Rate]
    if let data = UserDefaults.standard.data(forKey: "rates"),
       let storedRates = try? JSONDecoder().decode([Rate].self, from: data) {
      rates = storedRates
    } else {
      rates = []
    }
    
    rates.removeAll { $0.word == rate.word }
    rates.append(rate)
    
    if let data = try? JSONEncoder().encode(rates) {
      UserDefaults.standard.set(data, forKey: "rates")
    }
    
    updateStat()
  }
  
  func updateStat() {
    let totalWords = savedWordsCount()
    let learned = getRates().filter { $0.rate > 5 }.count
    
    print(getRates())
    
    UserDefaults(suiteName: "group.words")?.set(totalWords, forKey: "totalWords")
    UserDefaults(suiteName: "group.words")?.set(learned, forKey: "learnedWords")
  }
}
