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
import ObjectMapper

typealias JSON = [String: Any]

class UserService: NetworkService {
  
  // TODO: This promise should return a User object
  func getUser(userToken: String) -> Promise<User> {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      let target = ExecOnlineAPI.getUser(userToken: userToken)
      
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try response.mapJSON() as? JSON, let user: User = Mapper<User>().map(JSON: json) else {
              return
            }
            
            let realm = try Realm()
            try realm.write {
              realm.add(user)
            }
            
            resolve(user)
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
