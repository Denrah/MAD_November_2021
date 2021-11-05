//
//  OnboardingPageType.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

enum OnboardingPageType: CaseIterable {
  case first, second, third
  
  var title: String {
    switch self {
    case .first:
      return "Learn anytime\nand anywhere"
    case .second:
      return "Find a course\nfor you"
    case .third:
      return "Improve your skills"
    }
  }
  
  var subtitle: String {
    switch self {
    case .first:
      return "Quarantine is the perfect time to spend your\nday learning something new, from anywhere!"
    case .second:
      return "Quarantine is the perfect time to spend your\nday learning something new, from anywhere!"
    case .third:
      return "Quarantine is the perfect time to spend your\nday learning something new, from anywhere!"
    }
  }
  
  var image: UIImage? {
    switch self {
    case .first:
      return UIImage(named: "o1")
    case .second:
      return UIImage(named: "o2")
    case .third:
      return UIImage(named: "o3")
    }
  }
}
