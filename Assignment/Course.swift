//
//  Course.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Course: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var progress: Int = 0
  @objc dynamic var currentSegment: Int = 0
  @objc dynamic var currentModule: Int = 0
  @objc dynamic var studentStatus: String = ""
  @objc dynamic var canSkipAround: Bool = true
  @objc dynamic var appCompatible: Bool = true
  private var students = LinkingObjects(fromType: User.self, property: "courses")
  
  var student: User? {
    return students.first
  }
  
  var sfStudentUid: String? {
    return student?.contactUid
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  // MARK: - Initializers
  required convenience init?(map: Map) {
    self.init()
  }
  
  // MARK: - Mapping
  
  func mapping(map: Map) {
    id <- map["id"]
    progress <- map["progress"]
    currentSegment <- map["currentSegment"]
    currentModule <- map["currentModule"]
    studentStatus <- map["student_status"]
    canSkipAround <- map["can_skip_around"]
    appCompatible <- map["app_compatible"]
  }
}
