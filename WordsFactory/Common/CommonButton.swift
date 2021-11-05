//
//  CommonButton.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class CommonButton: UIButton {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: super.intrinsicContentSize.width + 32, height: 56)
  }
  
  init() {
    super.init(frame: .zero)
    backgroundColor = .primary
    layer.cornerRadius = 16
    setTitleColor(.white, for: .normal)
    titleLabel?.font = .rMedium?.withSize(16)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
