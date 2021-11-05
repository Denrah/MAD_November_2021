//
//  Rate.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation

struct Rate: Codable {
  init(word: String, rate: Int) {
    self.word = word
    self.rate = rate
  }
  
  let word: String
  var rate: Int
}
