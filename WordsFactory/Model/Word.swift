//
//  Word.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation

struct Word: Codable {
  let word: String?
  let phonetic: String?
  let phonetics: [Phonetics]?
  let meanings: [Meaning]?
}

struct Phonetics: Codable {
  let text: String?
  let audio: String?
  
  var audioURL: URL? {
    guard let audio = audio else {
      return nil
    }
    return URL(string: "https:" + audio)
  }
}

struct Meaning: Codable {
  let partOfSpeech: String?
  let definitions: [Definition]?
}

struct Definition: Codable {
  let definition: String?
  let example: String?
}
