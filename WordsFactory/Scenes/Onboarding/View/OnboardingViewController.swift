//
//  OnboardingViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class OnboardingViewController: BaseViewController {
  
  let scrollView = UIScrollView()
  let stackView = UIStackView()
  let nextButton = CommonButton()
  
  let viewModel: OnboardingViewModel
  
  init(viewModel: OnboardingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.setNavigationBarHidden(true, animated: false)
    
    view.addSubview(scrollView)
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    scrollView.contentInsetAdjustmentBehavior = .never
    scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    scrollView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.height.equalToSuperview()
    }
    
    viewModel.pageViewModels.forEach { pageViewModel in
      let pageView = OnboadingPageView(viewModel: pageViewModel)
      stackView.addArrangedSubview(pageView)
      pageView.snp.makeConstraints { make in
        make.width.equalTo(view.snp.width)
      }
    }
    
    let skipButton = UIButton()
    skipButton.setTitle("Skip", for: .normal)
    skipButton.titleLabel?.font = .rMedium
    skipButton.setTitleColor(.dark, for: .normal)
    view.addSubview(skipButton)
    skipButton.snp.makeConstraints { make in
      make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    skipButton.addTarget(self, action: #selector(showMain), for: .touchUpInside)
    
    view.addSubview(nextButton)
    nextButton.setTitle("Next", for: .normal)
    nextButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(32)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    
    // Do any additional setup after loading the view.
  }
  
  @objc func nextPage() {
    var page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
    if page < viewModel.pagesCount - 1 {
      page += 1
      scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(page), y: 0), animated: true)
    } else {
      showMain()
    }
  }
  
  @objc func showMain() {
    navigationController?.setViewControllers([DictionaryViewController(viewModel: DictionaryViewModel())], animated: true)
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

extension OnboardingViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
    if page == viewModel.pagesCount - 1 {
      nextButton.setTitle("Let’s Start", for: .normal)
    } else {
      nextButton.setTitle("Next", for: .normal)
    }
  }
}
