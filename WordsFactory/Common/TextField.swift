//
//  TextField.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class TextField: UITextField {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: super.intrinsicContentSize.width, height: 56)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
  }
  
  init() {
    super.init(frame: .zero)
    self.textColor = .darkGray
    self.font = .rRegular
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.gray.cgColor
    self.layer.cornerRadius = 12
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
