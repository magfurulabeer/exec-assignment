//
//  TokenService.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import then
import Moya
import KeychainAccess
import RealmSwift

class TokenService: NetworkService {
  
  // MARK: - POST /tokens
  
  func getToken(email: String, password: String) -> Promise<String>{
    let target = ExecOnlineAPI.requestToken(email: email, password: password)
    return requestThenSelect(target: target, path: "token")
  }
}
