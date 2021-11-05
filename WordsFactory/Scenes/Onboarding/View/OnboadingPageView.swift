//
//  OnboadingPageView.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class OnboadingPageView: UIView {

  init(viewModel: OnboadingPageViewModel) {
    super.init(frame: .zero)
    
    let containerView = UIView()
    addSubview(containerView)
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
      make.height.equalTo(446)
    }
    
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = viewModel.image
    containerView.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview()
      make.height.equalTo(264)
    }
    
    let pagesStackView = UIStackView()
    pagesStackView.axis = .horizontal
    pagesStackView.spacing = 12
    containerView.addSubview(pagesStackView)
    pagesStackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
      make.height.equalTo(6)
    }
    
    for index in 1...viewModel.totalPages {
      let dotView = UIView()
      dotView.layer.cornerRadius = 3
      if index == viewModel.index {
        dotView.backgroundColor = .secondary
        dotView.snp.makeConstraints { make in
          make.height.equalTo(6)
          make.width.equalTo(16)
        }
      } else {
        dotView.backgroundColor = UIColor(red: 0.835, green: 0.831, blue: 0.831, alpha: 1)
        dotView.snp.makeConstraints { make in
          make.height.equalTo(6)
          make.width.equalTo(6)
        }
      }
      
      pagesStackView.addArrangedSubview(dotView)
    }
    
    let subtitleLabel = UILabel()
    subtitleLabel.font = .rRegular
    subtitleLabel.text = viewModel.subtitle
    subtitleLabel.textColor = .darkGray
    subtitleLabel.numberOfLines = 2
    subtitleLabel.textAlignment = .center
    containerView.addSubview(subtitleLabel)
    subtitleLabel.snp.makeConstraints { make in
      make.bottom.equalTo(pagesStackView.snp.top).offset(-40)
      make.leading.trailing.equalToSuperview().inset(24)
    }
    
    let titleLabel = UILabel()
    titleLabel.font = .rMedium?.withSize(24)
    titleLabel.textColor = .dark
    titleLabel.text = viewModel.title
    titleLabel.numberOfLines = 2
    titleLabel.textAlignment = .center
    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.bottom.equalTo(subtitleLabel.snp.top).offset(-8)
      make.leading.trailing.equalToSuperview().inset(24)
    }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
