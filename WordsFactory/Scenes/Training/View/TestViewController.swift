//
//  TestViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class TestViewController: BaseViewController {
  
  let countLabel = UILabel()
  let textLabel = UILabel()
  
  let firstButton = WordButton()
  let secondButton = WordButton()
  let thirdButton = WordButton()
  
  let progressContainerView = UIView()
  let progressView = UIView()
  
  
  let gradientLayer = CAGradientLayer()
  
  var timer: Timer?
  var time: Int = 5
  
  private let viewModel: TestViewModel
  
  init(viewModel: TestViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    gradientLayer.frame = progressView.bounds
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    startTimer()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    hidesBottomBarWhenPushed = true
    
    let backButton = UIButton()
    backButton.setImage(UIImage(named: "b")?.withRenderingMode(.alwaysOriginal), for: .normal)
    view.addSubview(backButton)
    backButton.snp.makeConstraints { make in
      make.size.equalTo(48)
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.equalToSuperview().inset(16)
    }
    backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    
    view.addSubview(countLabel)
    countLabel.font = .rRegular?.withSize(16)
    countLabel.textColor = .darkGray
    countLabel.snp.makeConstraints { make in
      make.top.equalTo(backButton.snp.bottom).offset(32)
      make.centerX.equalToSuperview()
    }
    
    view.addSubview(textLabel)
    textLabel.font = .rMedium?.withSize(24)
    textLabel.textColor = .dark
    textLabel.numberOfLines = 0
    textLabel.snp.makeConstraints { make in
      make.top.equalTo(countLabel.snp.bottom).offset(8)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    
    view.addSubview(firstButton)
    firstButton.numberLabel.text = "A."
    firstButton.snp.makeConstraints { make in
      make.top.equalTo(textLabel.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    view.addSubview(secondButton)
    secondButton.numberLabel.text = "B."
    secondButton.snp.makeConstraints { make in
      make.top.equalTo(firstButton.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    view.addSubview(thirdButton)
    thirdButton.numberLabel.text = "C."
    thirdButton.snp.makeConstraints { make in
      make.top.equalTo(secondButton.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    
    firstButton.addTarget(self, action: #selector(select1), for: .touchUpInside)
    secondButton.addTarget(self, action: #selector(select2), for: .touchUpInside)
    thirdButton.addTarget(self, action: #selector(select3), for: .touchUpInside)
    
    
    view.addSubview(progressContainerView)
    progressContainerView.backgroundColor = .gray
    progressContainerView.layer.cornerRadius = 3
    progressContainerView.clipsToBounds = true
    progressContainerView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
      make.height.equalTo(6)
    }
    
    progressContainerView.addSubview(progressView)
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    gradientLayer.colors = [UIColor(red: 0.949, green: 0.624, blue: 0.247, alpha: 1).cgColor,
                            UIColor(red: 0.892, green: 0.338, blue: 0.163, alpha: 1).cgColor,
                            UIColor(red: 0.937, green: 0.286, blue: 0.286, alpha: 1).cgColor]
    progressView.layer.addSublayer(gradientLayer)
    progressView.clipsToBounds = true
    progressView.backgroundColor = .primary
    progressView.snp.makeConstraints { make in
      make.leading.top.bottom.equalToSuperview()
      make.width.equalToSuperview()
    }
    
    
    bindToViewModel()
    update()
    // Do any additional setup after loading the view.
  }
  
  @objc func back() {
    navigationController?.popViewController(animated: true)
  }
  
  func bindToViewModel() {
    viewModel.onDidUpdate = { [weak self] in
      self?.update()
      self?.startTimer()
    }
    viewModel.onDidFinish = { [weak self] correct, incorrect in
      self?.timer?.invalidate()
      self?.timer = nil
      self?.navigationController?.pushViewController(FinishViewController(correct: correct, incorrect: incorrect), animated: false)
    }
  }
  
  func update() {
    countLabel.text = viewModel.countText
    textLabel.text = viewModel.text
    firstButton.wordLabel.text = viewModel.firstAnswer
    secondButton.wordLabel.text = viewModel.secondAnswer
    thirdButton.wordLabel.text = viewModel.thirdAnswer
    
    time = 5
    
    self.progressView.snp.remakeConstraints { make in
      make.leading.top.bottom.equalToSuperview()
      make.width.equalToSuperview()
    }
    self.view.layoutIfNeeded()
    gradientLayer.frame = progressView.bounds
  }
  
  @objc func select1() {
    viewModel.select(index: 1)
  }
  
  @objc func select2() {
    viewModel.select(index: 2)
  }
  
  @objc func select3() {
    viewModel.select(index: 3)
  }
  
  func startTimer() {
    timer?.invalidate()
    timer = nil
    
    time -= 1
    
    self.progressView.snp.remakeConstraints { make in
      make.leading.top.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(CGFloat(self.time) / CGFloat(5))
    }
    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
      self.view.layoutIfNeeded()
    }
    
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
      self.time -= 1
      
      if self.time < 0 {
        self.timer?.invalidate()
        self.timer = nil
        timer.invalidate()
        self.viewModel.skip()
      } else {
        self.progressView.snp.remakeConstraints { make in
          make.leading.top.bottom.equalToSuperview()
          make.width.equalToSuperview().multipliedBy(CGFloat(self.time) / CGFloat(5))
        }
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
          self.view.layoutIfNeeded()
        }
      }
    })
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
