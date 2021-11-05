//
//  ViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setViewControllers([OnboardingViewController(viewModel: OnboardingViewModel())], animated: false)
    
    // Do any additional setup after loading the view.
  }


}

