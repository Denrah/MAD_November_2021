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
}
