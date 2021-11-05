//
//  VideoViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit
import WebKit

class VideoViewController: BaseViewController {
  
  let tabBarView = TabBarView()
  let webView = WKWebView()
  
  let viewModel: VideoViewModel
  
  init(viewModel: VideoViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(webView)
    webView.navigationDelegate = viewModel
    webView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(98)
    }
    
    if let request = viewModel.request {
      webView.load(request)
    }
    
    view.addSubview(tabBarView)
    tabBarView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
    }
    tabBarView.activeTab = .video
    tabBarView.onTap = { [weak self] tabType in
      switch tabType {
      case .dictionary:
        self?.navigationController?.setViewControllers([DictionaryViewController(viewModel: DictionaryViewModel())], animated: false)
      case .training:
        self?.navigationController?.setViewControllers([TrainingViewController(viewModel: TrainingViewModel())], animated: false)
      default:
        break
      }
    }
  }
}
