//
//  DictionaryRemoteService.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import Alamofire
import PromiseKit

enum DictionaryServiceError: LocalizedError {
  case failedToReadData, noSuchWord
  
  var errorDescription: String? {
    switch self {
    case .failedToReadData:
      return "Failed to read data"
    case .noSuchWord:
      return "No words found"
    }
  }
}

class DictionaryRemoteServiceSingletone: DictionaryService {
  static let shared = DictionaryRemoteServiceSingletone()
  
  private init() {}
  
  private let reachibilityManager = NetworkReachabilityManager(host: "https://api.dictionaryapi.dev")
  
  func isConnected() -> Bool {
    return reachibilityManager?.isReachable ?? false
  }
  
  func search(word: String) -> Promise<[Word]> {
    return Promise { seal in
      AF.request("https://api.dictionaryapi.dev/api/v2/entries/en/\(word)",
                 method: .get, encoding: URLEncoding.queryString).validate().responseData { response in
        switch response.result {
        case .success(let data):
          if let object = try? JSONDecoder().decode([Word].self, from: data) {
            seal.fulfill(object)
          } else {
            seal.reject(DictionaryServiceError.failedToReadData)
          }
        case .failure(let error):
          seal.reject(error)
        }
      }
    }
  }
  
  func save(word: Word) {
    // Do nothing
  }
}
