//
//  ViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setViewControllers([OnboardingViewController(viewModel: OnboardingViewModel())], animated: false)
    
    if WCSession.isSupported() {
      print("supported")
      let session = WCSession.default
      session.activate()
      session.sendMessage(["message": "123"], replyHandler: nil) { error in
        print(error.localizedDescription)
      }
    }
    
    // Do any additional setup after loading the view.
  }


}

