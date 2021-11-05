//
//  TabBarView.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class TabBarView: UIView {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: UIView.noIntrinsicMetric, height: 98)
  }
  
  let stackView = UIStackView()
  
  var onTap: ((TabType) -> Void)?
  
  var activeTab: TabType = .dictionary {
    didSet {
      stackView.arrangedSubviews.forEach { subview in
        (subview as? TabBarItemView)?.isActiveTab = false
        
        if (subview as? TabBarItemView)?.tabType == activeTab {
          (subview as? TabBarItemView)?.isActiveTab = true
        }
      }
    }
  }
  
  init() {
    super.init(frame: .zero)
    
    layer.borderWidth = 1
    layer.borderColor = UIColor.gray.cgColor
    backgroundColor = .white
    layer.cornerRadius = 16
    layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
    addSubview(stackView)
    stackView.distribution = .equalSpacing
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(25)
      make.top.equalToSuperview().inset(12)
    }
    
    TabType.allCases.forEach { type in
      let itemView = TabBarFactory.crateTabBarItem(ofType: type)
      itemView.onTap = { [weak self] tabType in
        self?.onTap?(tabType)
      }
      stackView.addArrangedSubview(itemView)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
