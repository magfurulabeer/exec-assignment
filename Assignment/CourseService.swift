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
  
  func getCourseLectureSegments(courseId: Int, id: Int) -> Promise<LectureSegment> {
    let target = ExecOnlineAPI.getCourseLectureSegments(courseId: courseId, id: id)
    return requestThenMap(target: target)
  }
}
