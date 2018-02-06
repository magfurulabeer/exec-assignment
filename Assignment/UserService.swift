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
  
  // MARK: - GET /user
  
  func getUser(userToken: String) -> Promise<User> {
    let target = ExecOnlineAPI.getUser(userToken: userToken)
    return requestThenMap(target: target)
  }
  
  // MARK: - POST /user/courses
  
  // Currently should only get first course
  func getUserCourses(userToken: String) -> Promise<[JSON]> {
    let target = ExecOnlineAPI.getUserCourses(userToken: userToken)
    return requestArray(target: target)
  }

}
