//
//  TabBarItemView.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class TabBarItemView: UIStackView {
  
  var isActiveTab: Bool = false {
    didSet {
      imageView.tintColor = isActiveTab ? .primary : .gray
      titleLabel.textColor = isActiveTab ? .primary : .gray
    }
  }
  
  let imageView = UIImageView()
  let titleLabel = UILabel()
  
  let tabType: TabType
  
  var onTap: ((TabType) -> Void)?
  
  init(tabType: TabType) {
    self.tabType = tabType
    
    super.init(frame: .zero)
    
    alignment = .center
    axis = .vertical
    spacing = 2
    
    addArrangedSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.image = tabType.icon?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .gray
    imageView.snp.makeConstraints { make in
      make.size.equalTo(24)
    }
    
    addArrangedSubview(titleLabel)
    titleLabel.font = .rRegular
    titleLabel.text = tabType.title
    titleLabel.textColor = .gray
    titleLabel.textAlignment = .center
    
    snp.makeConstraints { make in
      make.width.equalTo(70)
    }
    
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
  }
  
  @objc func handleTap() {
    onTap?(tabType)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
