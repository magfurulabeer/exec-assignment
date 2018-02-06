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
  
  func getCourse(courseId: Int) -> Promise<JSON> {
    let target = ExecOnlineAPI.getCourse(id: courseId)
    return request(target: target)
  }
}
