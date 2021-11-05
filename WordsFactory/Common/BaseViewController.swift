//
//  BaseViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit
import SnapKit
import MBProgressHUD

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    // Do any additional setup after loading the view.
  }
  
  func startLoading() {
    MBProgressHUD.showAdded(to: navigationController?.view ?? UIView(), animated: true)
  }
  
  func stopLoading() {
    MBProgressHUD.hide(for: navigationController?.view ?? UIView(), animated: true)
  }
  
  func showError(_ error: Error) {
    showAlert(text: error.localizedDescription)
  }
  
  func showAlert(text: String?) {
    let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
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
