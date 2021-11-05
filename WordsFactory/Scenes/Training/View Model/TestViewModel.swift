//
//  TestViewModel.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation

class TestViewModel {
  var onDidUpdate: (() -> Void)?
  var onDidFinish: ((Int, Int) -> Void)?
  
  let dictionaryService = DictionaryServiceProxy()
  
  var countText: String {
    return "\(step) of \(totalSteps)"
  }
  
  var text: String? {
    self.words[step - 1].meanings?.first?.definitions?.first?.definition
  }
  
  private(set) var firstAnswer: String = ""
  private(set) var secondAnswer: String = ""
  private(set) var thirdAnswer: String = ""
  
  private var rightAnswer: Int = 0
  private var rightWord: String?
  
  private var step: Int = 0
  private var totalSteps: Int = 0
  private var words: [Word] = []
  
  private var correct = 0
  private var incorrect = 0
  
  init() {
    let words = dictionaryService.savedWords()
    let allRates = dictionaryService.getRates()
    let rates = words.map { word -> Rate in
      if let rate = allRates.first(where: { $0.word == word.word }) {
        return rate
      } else {
        let rate = Rate(word: word.word ?? "", rate: 0)
        dictionaryService.saveRate(rate: rate)
        return rate
      }
    }.sorted { $0.rate < $1.rate }.prefix(10)
    
    let wordsToLearn = rates.compactMap { rate in words.first { $0.word == rate.word } }
    
    step = 1
    totalSteps = wordsToLearn.count
    self.words = wordsToLearn
    
    makeAnswers()
  }
  
  func makeAnswers() {
    rightAnswer = Int.random(in: 1...3)
    let correctWord = self.words[step - 1].word
    let wrong1 = dictionaryService.savedWords().filter { $0.word != correctWord }.randomElement()?.word
    let wrong2 = dictionaryService.savedWords().filter { $0.word != correctWord && $0.word != wrong1 }.randomElement()?.word
    
    self.rightWord = correctWord
    
    switch rightAnswer {
    case 1:
      firstAnswer = correctWord ?? ""
      secondAnswer = wrong1 ?? (correctWord == "Smiling" ? "Freezing" : "Smiling")
      thirdAnswer = wrong2 ?? (correctWord == "Smiling" ? "Freezing" : "Smiling")
    case 2:
      secondAnswer = correctWord ?? ""
      firstAnswer = wrong1 ?? (correctWord == "Smiling" ? "Freezing" : "Smiling")
      thirdAnswer = wrong2 ?? (correctWord == "Smiling" ? "Freezing" : "Smiling")
    case 3:
      thirdAnswer = correctWord ?? ""
      secondAnswer = wrong1 ?? (correctWord == "Smiling" ? "Freezing" : "Smiling")
      firstAnswer = wrong2 ?? (correctWord == "Smiling" ? "Freezing" : "Smiling")
    default:
      return
    }
  }
  
  func skip() {
    select(index: rightAnswer + 1)
  }
  
  func select(index: Int) {
    var rate = dictionaryService.getRates().first { $0.word == rightWord } ?? Rate(word: rightWord ?? "", rate: 0)
    if index == rightAnswer {
      rate.rate += 1
      correct += 1
    } else {
      rate.rate -= 1
      incorrect += 1
    }
    
    dictionaryService.saveRate(rate: rate)
    
    if step < totalSteps {
      step += 1
      makeAnswers()
      onDidUpdate?()
    } else {
      onDidFinish?(correct, incorrect)
    }
  }
}
