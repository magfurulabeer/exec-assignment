//
//  LoginViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

// MARK: Primary Class Description
class LoginViewController: UIViewController {

  // MARK : - IBOutlets
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  // MARK: - Properties
  var viewModel: LoginViewModel! {
    didSet {
      updateView()
    }
  }
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    textFieldDidChange(emailTextField)
//    updateView()
  }
}

// MARK: - IBActions
extension LoginViewController {
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    viewModel.login()
  }
  
  @IBAction func textFieldDidChange(_ sender: UITextField) {
    viewModel.email = emailTextField.text ?? ""
    viewModel.password = passwordTextField.text ?? "ERROR"
  }
}

// MARK: Helper Functions
extension LoginViewController {
  func updateView() {
    guard loginButton != nil else { return } // If called before uiviewcontroller lays out subviews
    loginButton.isEnabled = viewModel.buttonIsEnabled
    loginButton.backgroundColor = viewModel.buttonIsEnabled ? Constants.Colors.darkRed : Constants.Colors.darkRed.withAlphaComponent(0.8)
  }
}
