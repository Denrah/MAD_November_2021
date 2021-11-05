//
//  OnboardingViewModel.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import UIKit

class OnboardingViewModel {
  let pageViewModels = OnboardingPagesFactory.makePageViewModels()
  
  var pagesCount: Int {
    pageViewModels.count
  }
}
