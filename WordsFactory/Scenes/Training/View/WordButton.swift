//
//  WordButton.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class WordButton: UIButton {
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: super.intrinsicContentSize.width, height: 58)
  }
  
  let numberLabel = UILabel()
  let wordLabel = UILabel()
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? .lightGray : .white
      layer.borderColor = isHighlighted ? UIColor.primary.cgColor : UIColor.gray.cgColor
    }
  }
  
  init() {
    super.init(frame: .zero)
    
    addSubview(numberLabel)
    numberLabel.textColor = .dark
    numberLabel.font = .rRegular?.withSize(16)
    numberLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(24)
    }
    
    addSubview(wordLabel)
    wordLabel.textColor = .dark
    wordLabel.font = .rRegular?.withSize(16)
    wordLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(numberLabel.snp.trailing).offset(16)
    }
    
    backgroundColor = .white
    layer.borderWidth = 1
    layer.borderColor = UIColor.gray.cgColor
    layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
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
