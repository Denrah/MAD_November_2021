//
//  TrainingViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class TrainingViewController: BaseViewController {
  
  let trainingText = UILabel()
  let startButton = CommonButton()
  
  let tabBarView = TabBarView()
  
  let countdownLabel = UILabel()
  
  let viewModel: TrainingViewModel
  
  init(viewModel: TrainingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startButton.isHidden = false
    countdownLabel.isHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    
    view.addSubview(trainingText)
    trainingText.numberOfLines = 0
    trainingText.textAlignment = .center
    trainingText.textColor = .dark
    trainingText.attributedText = viewModel.title
    trainingText.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.centerY.equalToSuperview().offset(-170)
    }
    
    if viewModel.hasWords {
      view.addSubview(startButton)
      startButton.setTitle("Start", for: .normal)
      startButton.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().inset(33)
        make.bottom.equalToSuperview().inset(187)
      }
      startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
    }
    
    view.addSubview(countdownLabel)
    countdownLabel.font = .rBold?.withSize(56)
    countdownLabel.snp.makeConstraints { make in
      make.top.equalTo(trainingText.snp.bottom).offset(199)
      make.centerX.equalToSuperview()
    }
    
    view.addSubview(tabBarView)
    tabBarView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
    }
    tabBarView.activeTab = .training
    tabBarView.onTap = { [weak self] tabType in
      switch tabType {
      case .dictionary:
        self?.navigationController?.setViewControllers([DictionaryViewController(viewModel: DictionaryViewModel())], animated: false)
      case .video:
        self?.navigationController?.setViewControllers([VideoViewController(viewModel: VideoViewModel())], animated: false)
      default:
        break
      }
    }
    // Do any additional setup after loading the view.
  }
  
  var time = 5
  
  @objc func start() {
    startButton.isHidden = true
    countdownLabel.isHidden = false
    time = 5
    countdownLabel.text = "\(time)"
    self.countdownLabel.textColor = UIColor(red: 0.892, green: 0.338, blue: 0.163, alpha: 1)
    
    
    _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
      self.time -= 1
      if self.time < 0 {
        timer.invalidate()
        self.navigationController?.pushViewController(TestViewController(viewModel: TestViewModel()), animated: true)
      } else if self.time == 0 {
        self.countdownLabel.text = "GO!"
        self.countdownLabel.textColor = UIColor(red: 0.892, green: 0.338, blue: 0.163, alpha: 1)
      } else {
        self.countdownLabel.text = "\(self.time)"
      }
      
      switch self.time {
      case 4:
        self.countdownLabel.textColor = UIColor(red: 0.397, green: 0.666, blue: 0.917, alpha: 1)
      case 3:
        self.countdownLabel.textColor = UIColor(red: 0.357, green: 0.627, blue: 0.573, alpha: 1)
      case 2:
        self.countdownLabel.textColor = UIColor(red: 0.95, green: 0.626, blue: 0.245, alpha: 1)
      case 1:
        self.countdownLabel.textColor = UIColor(red: 0.938, green: 0.285, blue: 0.285, alpha: 1)
      default:
        break
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
