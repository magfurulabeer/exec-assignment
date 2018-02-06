//
//  LoginViewModel.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation

struct LoginViewModel {
  // MARK: - Public Variables
  var email: String = ""
  var password: String = ""
  
  var buttonIsEnabled: Bool {
    return emailIsValid && passwordIsValid
  }
  
  // MARK: - Private Variables
  private var emailIsValid: Bool {
    let isLongEnough = email.count >= 8
    let containsEmailSymbols = email.contains("@") && email.contains(".")
    return isLongEnough// && containsEmailSymbols
  }
  private var passwordIsValid: Bool {
    let isLongEnough = password.count >= 8
    let containsMixedCase = password != password.uppercased() && password != password.lowercased()
    return isLongEnough// && containsMixedCase
  }
}
