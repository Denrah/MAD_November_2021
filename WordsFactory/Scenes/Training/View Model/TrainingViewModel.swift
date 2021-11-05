//
//  TrainingViewModel.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import UIKit

class TrainingViewModel {
  let dictionaryService = DictionaryServiceProxy()
  
  let title: NSAttributedString
  let hasWords: Bool
  
  init() {
    let wordsCount = dictionaryService.savedWordsCount()
    self.hasWords = wordsCount > 0
    
    var string = NSMutableAttributedString(string: "There are ", attributes: [.foregroundColor: UIColor.dark, .font: UIFont.rMedium?.withSize(24)])
    string.append(NSAttributedString(string: "\(wordsCount) ", attributes: [.foregroundColor: UIColor.primary, .font: UIFont.rMedium?.withSize(24)]))
    string.append(NSAttributedString(string: "words\nin your Dictionary.\n\nStart the Training?", attributes: [.foregroundColor: UIColor.dark, .font: UIFont.rMedium?.withSize(24)]))
    
    if wordsCount > 0 {
      self.title = string
    } else {
      self.title = NSAttributedString(string: "Add words to dictionary", attributes: [.foregroundColor: UIColor.dark, .font: UIFont.rMedium?.withSize(24)])
    }
  }
}
