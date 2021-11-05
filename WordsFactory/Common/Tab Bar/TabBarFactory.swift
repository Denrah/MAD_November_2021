//
//  TabBarFactory.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation

class TabBarFactory {
  static func crateTabBarItem(ofType type: TabType) -> TabBarItemView {
    return TabBarItemView(tabType: type)
  }
}
