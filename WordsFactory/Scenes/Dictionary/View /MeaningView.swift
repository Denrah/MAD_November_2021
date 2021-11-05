//
//  MeaningView.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class MeaningView: UIView {
  let meaningLabel = UILabel()
  let exampleLabel = UILabel()
  
  init(viewModel: MeaningViewModel) {
    super.init(frame: .zero)
    
    layer.borderWidth = 1
    layer.borderColor = UIColor.gray.cgColor
    layer.cornerRadius = 16
    
    addSubview(meaningLabel)
    meaningLabel.numberOfLines = 0
    meaningLabel.textColor = .dark
    meaningLabel.font = .rRegular
    meaningLabel.text = viewModel.meaning
    meaningLabel.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview().inset(16)
    }
    
    addSubview(exampleLabel)
    exampleLabel.numberOfLines = 0
    exampleLabel.font = .rRegular
    exampleLabel.snp.makeConstraints { make in
      make.top.equalTo(meaningLabel.snp.bottom).offset(8)
      make.leading.trailing.bottom.equalToSuperview().inset(16)
    }
    
    let string = NSMutableAttributedString(string: "Example: ", attributes: [.font: UIFont.rRegular, .foregroundColor: UIColor.secondary])
    string.append(NSAttributedString(string: viewModel.example ?? "", attributes: [.font: UIFont.rRegular, .foregroundColor: UIColor.dark]))
    
    exampleLabel.attributedText = string
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
