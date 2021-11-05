//
//  TabType.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import UIKit

enum TabType: CaseIterable {
  case dictionary, training, video
  
  var icon: UIImage? {
    switch self {
    case .dictionary:
      return UIImage(named: "dic")
    case .training:
      return UIImage(named: "train")
    case .video:
      return UIImage(named: "vid")
    }
  }
  
  var title: String {
    switch self {
    case .dictionary:
      return "Dictionary"
    case .training:
      return "Training"
    case .video:
      return "Video"
    }
  }
}
