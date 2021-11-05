//
//  DictPlaceholderView.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class DictPlaceholderView: UIView {
  init() {
    super.init(frame: .zero)
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "dic-pl")
    imageView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(253)
    }
    
    addSubview(titleLabel)
    titleLabel.font = .rMedium?.withSize(24)
    titleLabel.textColor = .dark
    titleLabel.text = "No word"
    titleLabel.textAlignment = .center
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(32)
      make.leading.trailing.equalToSuperview()
    }
    
    addSubview(subtitleLabel)
    subtitleLabel.font = .rRegular
    subtitleLabel.textColor = .darkGray
    subtitleLabel.text = "Input something to find it in dictionary"
    subtitleLabel.textAlignment = .center
    subtitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
