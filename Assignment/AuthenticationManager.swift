//
//  AuthenticationManager.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import then
import KeychainAccess
import RealmSwift

// MARK: - Base Description
class AuthenticationManager {
  
  // MARK: - Properties
  fileprivate let tokenService = TokenService()
  fileprivate let userService = UserService()
  fileprivate let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
  
  // MARK: - Functionalities
  
  func login(email: String, password: String) -> Promise<Void> {
    return async { [weak self] in
      guard let this = self else { fatalError() }
      
      let token = try await(this.tokenService.getToken(email: email, password: password))
      this.saveTokenToKeychain(token: token)
      let user = try await(this.userService.getUser(userToken: token))
      this.persistUser(user)
    }
  }
  
}


// MARK: - Helper Methods
extension AuthenticationManager {
  fileprivate func saveTokenToKeychain(token: String) {
    keychain[Constants.Params.userToken] = token
  }
  
  fileprivate func persistUser(_ user: User) {
    OperationQueue.main.addOperation {
      do {
        let realm = Realm.shared
        try realm.write {
          realm.add(user, update: true)
        }
      } catch let err {
        // Implement error handling
      }
    }
  }
}
