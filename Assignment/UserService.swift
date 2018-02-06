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

class UserService: NetworkService {
  
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
              realm.add(user, update: true)
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
  
  func getUserCourses(userToken: String) -> Promise<Course> {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      let target = ExecOnlineAPI.getUserCourses(userToken: userToken)
      print("Promises 12345")
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try response.mapJSON() as? [JSON] else {
              reject(NetworkError.custom("No courses retrieved"))
              return
            }
            
            let courses: [Course] = Mapper<Course>().mapArray(JSONArray: json)
            guard courses.count > 0 else {
              reject(NetworkError.custom("No courses retrieved"))
              return
            }

            let realm = try Realm()
            try realm.write {
              realm.add(courses, update: true)
            }

            resolve(courses.first ?? Course())
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
