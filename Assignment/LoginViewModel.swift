//
//  LoginViewModel.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

class LoginViewModel: ViewModel {
  // MARK: - Public Variables
  var email: String = ""
  var password: String = ""
  var coordinator: Coordinator
  
  var buttonIsEnabled: Bool {
    return emailIsValid && passwordIsValid
  }
  
  init(coordinator: Coordinator) {
    self.coordinator = coordinator
  }
  
  // MARK: - Private Variables
  private let authenticationManager = AuthenticationManager()

  private var emailIsValid: Bool {
    let isLongEnough = email.count >= 8
    return isLongEnough// && containsEmailSymbols
  }
  private var passwordIsValid: Bool {
    let isLongEnough = password.count >= 8
    return isLongEnough// && containsMixedCase
  }
  
  // Methods
  
  public func login() {
    // TODO: What if authentication fails? -> No mapping if user doesn't have proper id?
    authenticationManager.login(email: email, password: password)
      .finally(transitionToCourseScreen)
  }
  
  private func transitionToCourseScreen() {
    OperationQueue.main.addOperation { [weak self] in
      guard let this = self else { fatalError() }
      this.coordinator.root(scene: Scene.course)
//      let storyboard = UIStoryboard(name: "App", bundle: Bundle.main)
//      let viewController = storyboard.instantiateInitialViewController()!
//      let appDelegate = UIApplication.shared.delegate as! AppDelegate
//      appDelegate.window!.rootViewController = viewController
//      appDelegate.window!.makeKeyAndVisible()
    }
  }
}
