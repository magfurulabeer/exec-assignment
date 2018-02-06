//
//  CourseManager.swift
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
class CourseManager {
  
  // MARK: - Properties
  fileprivate let userService = UserService()
  fileprivate let courseService = CourseService()
  fileprivate let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
  
  // MARK: - Functionalities
  
  func retrieveCourse() -> Promise<Void> {
    return async { [weak self] in
      guard let this = self, let userToken = this.keychain[Constants.Params.userToken] else { fatalError() }
      
      let userCourseData = try await(this.userService.getUserCourses(userToken: userToken))
      guard let firstCourseData = userCourseData.first, let courseId = firstCourseData["id"] as? Int else {
        print("No courses to retrieve")
        return
      }

      let courseContentData = try await(this.courseService.getCourse(courseId: courseId))
      let courseData = firstCourseData.merging(courseContentData, uniquingKeysWith: { (a, b) -> Any in
        return b
      })

      guard let course: Course = Mapper<Course>().map(JSON: courseData)  else {
        print("Could not map course")
        return
      }
      
      let realm = try! Realm()
      try! realm.write {
        realm.add(course, update: true)
      }
//      this.persistCourse(course)
      print("-------------")
      print(course)
    }
  }
  
}


// MARK: - Helper Methods
extension CourseManager {
  fileprivate func persistCourse(_ course: Course) {
//    guard let realm = course.realm else { print("Course has no realm"); return }
//    realm
    Realm.insert(course, update: true)
  }
  
}
