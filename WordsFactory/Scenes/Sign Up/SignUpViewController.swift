//
//  SignUpViewController.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import UIKit

class SignUpViewController: BaseViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let signUpButton = CommonButton()
    signUpButton.setTitle("Sign up", for: .normal)
    view.addSubview(signUpButton)
    signUpButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(100)
    }
    signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    
    let imageView = UIImageView()
    imageView.image = UIImage(named: "sign")
    view.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(58)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(253)
    }
    
    let titleLbl = UILabel()
    titleLbl.text = "Sign up"
    titleLbl.textColor = .dark
    titleLbl.font = .rMedium?.withSize(24)
    view.addSubview(titleLbl)
    titleLbl.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(imageView.snp.bottom).offset(16)
    }
    
    // Do any additional setup after loading the view.
  }
  
  @objc func signUp() {
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
