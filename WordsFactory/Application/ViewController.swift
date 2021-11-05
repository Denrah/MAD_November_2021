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
    
    navigationController?.setViewControllers([DictionaryViewController(viewModel: DictionaryViewModel())], animated: false)
    // Do any additional setup after loading the view.
  }


}

