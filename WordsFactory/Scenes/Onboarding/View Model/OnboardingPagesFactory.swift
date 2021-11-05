//
//  OnboardingPagesFactory.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import UIKit

class OnboardingPagesFactory {
  static func makePageViewModels() -> [OnboadingPageViewModel] {
    return OnboardingPageType.allCases.enumerated().map { index, item in
      OnboadingPageViewModel(image: item.image,
                             title: item.title,
                             subtitle: item.subtitle,
                             index: index + 1,
                             totalPages: OnboardingPageType.allCases.count)
    }
  }
}
