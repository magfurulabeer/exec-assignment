//
//  UserService.swift
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

class UserService: NetworkService {
  
  // TODO: This promise should return a User object
  func getUser(userToken: String) -> Promise<Data> {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      let target = ExecOnlineAPI.getUser(userToken: userToken)
      
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try JSONSerialization.jsonObject(with: response.data, options: [.mutableContainers]) as? [String: String] else {
                reject(NetworkError.custom("Token could not be parsed"))
                return
            }
            
            print("JSON IS\n\n\n", json)
            resolve(response.data)
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
