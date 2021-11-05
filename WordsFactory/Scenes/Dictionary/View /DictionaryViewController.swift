//
//  DictionaryViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit
import TPKeyboardAvoiding

class DictionaryViewController: BaseViewController {
  
  let scrollView = TPKeyboardAvoidingScrollView()
  let placeholder = DictPlaceholderView()
  let searchTF = TextField()
  let containerView = UIView()
  
  
  let wordLabel = UILabel()
  let phoneticLabel = UILabel()
  let partTitleLabel = UILabel()
  let partLabel = UILabel()
  let meaningsLabel = UILabel()
  let stackView = UIStackView()
  let addToDictionaryButton = CommonButton()
  
  let tabBarView = TabBarView()
  
  let viewModel: DictionaryViewModel
  
  init(viewModel: DictionaryViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    view.addSubview(placeholder)
    placeholder.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.centerY.equalToSuperview().offset(-40)
    }
    
    let searchButton = UIButton()
    searchButton.setImage(UIImage(named: "search"), for: .normal)
    searchButton.tintColor = .dark
    searchButton.snp.makeConstraints { make in
      make.height.equalTo(24)
      make.width.equalTo(60)
    }
    searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
    
    view.addSubview(searchTF)
    searchTF.rightViewMode = .always
    searchTF.rightView = searchButton
    searchTF.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    
    view.addSubview(scrollView)
    scrollView.showsVerticalScrollIndicator = false
    scrollView.contentInset.bottom = 186
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(searchTF.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    scrollView.addSubview(containerView)
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
    }
    
    containerView.addSubview(wordLabel)
    wordLabel.textColor = .dark
    wordLabel.font = .rMedium?.withSize(24)
    wordLabel.numberOfLines = 0
    wordLabel.textColor = .dark
    wordLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview().inset(16)
    }
    
    containerView.addSubview(phoneticLabel)
    phoneticLabel.font = .rRegular
    phoneticLabel.textColor = .primary
    phoneticLabel.snp.makeConstraints { make in
      make.leading.equalTo(wordLabel.snp.trailing).offset(16)
      make.firstBaseline.equalTo(wordLabel.snp.firstBaseline)
    }
    
    let speakBtn = UIButton()
    speakBtn.setImage(UIImage(named: "speak"), for: .normal)
    speakBtn.tintColor = .primary
    containerView.addSubview(speakBtn)
    speakBtn.snp.makeConstraints { make in
      make.width.equalTo(26)
      make.height.equalTo(23)
      make.leading.equalTo(phoneticLabel.snp.trailing).offset(16)
      make.centerY.equalTo(phoneticLabel)
      make.trailing.lessThanOrEqualToSuperview().inset(16)
    }
    
    speakBtn.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
    
    containerView.addSubview(partTitleLabel)
    partTitleLabel.textColor = .dark
    partTitleLabel.font = .rMedium?.withSize(20)
    partTitleLabel.text = "Part of Speech:"
    partTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(wordLabel.snp.bottom).offset(16)
      make.leading.equalToSuperview().inset(16)
    }
    
    containerView.addSubview(partLabel)
    partLabel.textColor = .dark
    partLabel.font = .rRegular
    partLabel.snp.makeConstraints { make in
      make.leading.equalTo(partTitleLabel.snp.trailing).offset(16)
      make.firstBaseline.equalTo(partTitleLabel.snp.firstBaseline)
    }
    
    containerView.addSubview(meaningsLabel)
    meaningsLabel.textColor = .dark
    meaningsLabel.text = "Meanings:"
    meaningsLabel.font = .rMedium?.withSize(20)
    meaningsLabel.snp.makeConstraints { make in
      make.top.equalTo(partTitleLabel.snp.bottom).offset(16)
      make.leading.equalToSuperview().inset(16)
    }
    
    containerView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.snp.makeConstraints { make in
      make.top.equalTo(meaningsLabel.snp.bottom).offset(11)
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(16)
    }
    
    view.addSubview(addToDictionaryButton)
    addToDictionaryButton.setTitle("Add to Dictionary", for: .normal)
    addToDictionaryButton.isHidden = true
    addToDictionaryButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(33)
      make.bottom.equalToSuperview().inset(114)
    }
    
    addToDictionaryButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    
    
    view.addSubview(tabBarView)
    tabBarView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
    }
    tabBarView.activeTab = .dictionary
    tabBarView.onTap = { [weak self] tabType in
      switch tabType {
      case .video:
        self?.navigationController?.setViewControllers([VideoViewController(viewModel: VideoViewModel())], animated: false)
      default:
        break
      }
    }
    
    scrollView.isHidden = true
    bindToViewModel()
    
    // Do any additional setup after loading the view.
  }
  
  @objc func search() {
    viewModel.search(word: searchTF.text)
    view.endEditing(true)
  }
  
  @objc func save() {
    viewModel.save()
  }
  
  @objc func playAudio() {
    viewModel.playAudio()
  }
  
  func bindToViewModel() {
    viewModel.onDidStartRequest = { [weak self] in
      self?.startLoading()
    }
    viewModel.onDidEndRequest = { [weak self] in
      self?.stopLoading()
    }
    viewModel.onDidLoadData = { [weak self] in
      guard let self = self else { return }
      self.placeholder.isHidden = self.viewModel.hasWord
      self.scrollView.isHidden = !self.viewModel.hasWord
      self.addToDictionaryButton.isHidden = !self.viewModel.hasWord
      self.wordLabel.text = self.viewModel.wordName
      self.phoneticLabel.text = self.viewModel.phonetic
      self.partLabel.text = self.viewModel.part
      self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
      self.viewModel.meaningViewModels.forEach { meaningViewModel in
        let meaningViewModel = MeaningView(viewModel: meaningViewModel)
        self.stackView.addArrangedSubview(meaningViewModel)
      }
    }
    viewModel.onDidReceiveError = { [weak self] error in
      self?.showError(error)
    }
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
