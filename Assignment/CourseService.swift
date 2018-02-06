//
//  CourseService.swift
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

class CourseService: NetworkService {
  
  func getCourse(userToken: String) -> Promise<Course> {
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
              realm.add(user, update: true)
            }
            
            
            resolve(Course())
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
