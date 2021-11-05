//
//  Word.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation

struct Word: Codable {
  init(word: String?, phonetic: String?, phonetics: [Phonetics]?, meanings: [Meaning]?) {
    self.word = word
    self.phonetic = phonetic
    self.phonetics = phonetics
    self.meanings = meanings
  }
  
  let word: String?
  let phonetic: String?
  let phonetics: [Phonetics]?
  let meanings: [Meaning]?
}

struct Phonetics: Codable {
  init(text: String?, audio: String?) {
    self.text = text
    self.audio = audio
  }
  
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
  init(partOfSpeech: String?, definitions: [Definition]?) {
    self.partOfSpeech = partOfSpeech
    self.definitions = definitions
  }
  
  let partOfSpeech: String?
  let definitions: [Definition]?
}

struct Definition: Codable {
  init(definition: String?, example: String?) {
    self.definition = definition
    self.example = example
  }
  
  let definition: String?
  let example: String?
}
