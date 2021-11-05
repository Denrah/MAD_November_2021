//
//  FinishViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class FinishViewController: BaseViewController {
  
  let correct: Int
  let incorrecr: Int
  
  init(correct: Int, incorrect: Int) {
    self.correct = correct
    self.incorrecr = incorrect
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let backButton = UIButton()
    backButton.setImage(UIImage(named: "b")?.withRenderingMode(.alwaysOriginal), for: .normal)
    view.addSubview(backButton)
    backButton.snp.makeConstraints { make in
      make.size.equalTo(48)
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.equalToSuperview().inset(16)
    }
    backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    
    let containerView = UIView()
    view.addSubview(containerView)
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }
    
    let imageView = UIImageView()
    imageView.image = UIImage(named: "f")
    containerView.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview()
      make.height.equalTo(253)
    }
    
    let titleLabel = UILabel()
    titleLabel.font = .rMedium?.withSize(24)
    titleLabel.textColor = .dark
    titleLabel.text = "Training is finished"
    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(imageView.snp.bottom).offset(32)
    }
    
    let correctLabel = UILabel()
    containerView.addSubview(correctLabel)
    correctLabel.font = .rRegular
    correctLabel.textColor = .darkGray
    correctLabel.textAlignment = .center
    correctLabel.numberOfLines = 0
    correctLabel.text = "Correct: \(correct)\nIncorrent: \(incorrecr)"
    correctLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.centerX.equalToSuperview()
    }
    
    let againButton = CommonButton()
    containerView.addSubview(againButton)
    againButton.setTitle("Again", for: .normal)
    againButton.snp.makeConstraints { make in
      make.top.equalTo(correctLabel.snp.bottom).offset(32)
      make.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(33)
    }
    againButton.addTarget(self, action: #selector(again), for: .touchUpInside)
    
    // Do any additional setup after loading the view.
  }
  
  
  @objc func back() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc func again() {
    navigationController?.setViewControllers([TrainingViewController(viewModel: TrainingViewModel()), TestViewController(viewModel: TestViewModel())], animated: false)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
