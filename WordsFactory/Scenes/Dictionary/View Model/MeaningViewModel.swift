//
//  MeaningViewModel.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation

class MeaningViewModel {
  var meaning: String? {
    definition.definition
  }
  
  var example: String? {
    definition.example
  }
  
  private let definition: Definition
  
  init(definition: Definition) {
    self.definition = definition
  }
}
