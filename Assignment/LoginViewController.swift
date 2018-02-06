//
//  LoginViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  let tokenService = TokenService()
  let userService = UserService()
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    tokenService
      .getToken(email: emailTextField.text!, password: passwordTextField.text!)
      .then(userService.getUser)
      .finally {
        OperationQueue.main.addOperation { [weak self] in
          guard let this = self else { return }
          this.transitionToCourse()
        }
    }
  }
  
  func transitionToCourse() {
    let storyboard = UIStoryboard(name: "App", bundle: Bundle.main)
    let viewController = storyboard.instantiateInitialViewController()!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window!.rootViewController = viewController
    appDelegate.window!.makeKeyAndVisible()
  }
}
