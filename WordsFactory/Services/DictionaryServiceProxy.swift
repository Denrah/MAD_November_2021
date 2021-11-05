//
//  DictionaryServiceProxy.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import PromiseKit

protocol DictionaryService {
  func search(word: String) -> Promise<[Word]>
  func save(word: Word)
  func savedWords() -> [Word]
  func savedWordsCount() -> Int
  func getRates() -> [Rate]
  func saveRate(rate: Rate)
}

class DictionaryServiceProxy: DictionaryService {
  private let remoteService = DictionaryRemoteServiceSingletone.shared
  private let localService = DictionaryLocalServiceSingletone.shared
  
  func search(word: String) -> Promise<[Word]> {
    if remoteService.isConnected() {
      return remoteService.search(word: word)
    } else {
      return localService.search(word: word)
    }
  }
  
  func save(word: Word) {
    localService.save(word: word)
  }
  
  func savedWords() -> [Word] {
    return localService.savedWords()
  }
  
  func savedWordsCount() -> Int {
    localService.savedWordsCount()
  }
  
  func getRates() -> [Rate] {
    return localService.getRates()
  }
  
  func saveRate(rate: Rate) {
    localService.saveRate(rate: rate)
  }
}
