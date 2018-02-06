//
//  Course.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift

class Course: Object {
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
}
