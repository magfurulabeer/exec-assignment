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
  
  @discardableResult
  func getToken(email: String, password: String) -> Promise<String>{
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      let target = ExecOnlineAPI.requestToken(email: email, password: password)
      
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try JSONSerialization.jsonObject(with: response.data, options: [.mutableContainers]) as? [String: String],
              let token = json["token"] else {
                reject(NetworkError.custom("Token could not be parsed"))
                return
            }
            
            this.keychain[Constants.Params.userToken] = token
            resolve(token)
          } catch let err {
            reject(err)
          }
          
        case .failure(let error):
          reject(error)
        }
      })
      
    }
  }

}
