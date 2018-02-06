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
  @objc dynamic var title: String = ""
  @objc dynamic var startOn: String = ""
  @objc dynamic var endOn: String = ""
  @objc dynamic var institutionLogo: String = ""
  @objc dynamic var progress: Int = 0
  @objc dynamic var currentSegment: Int = 0
  @objc dynamic var currentModule: Int = 0
  @objc dynamic var studentStatus: String = ""
  @objc dynamic var canSkipAround: Bool = true
  @objc dynamic var appCompatible: Bool = true
  var courseModules = List<Module>()
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
    startOn <- map["start_on"]
    endOn <- map["end_on"]
    title <- map["title"]

    // Modules
//    let modulesData = map.JSON["course_modules"] as! [JSON] // TODO: Remove forced cast
//
//    let modules = modulesData
//      .map { Mapper<Module>().map(JSON: $0) ?? Module() }
//      .filter { $0.id != 0 } // Check if id can be 0
//
//    do {
//      let realm = try Realm()
//      try realm.write {
//        realm.add(modules, update: true)
//
//        let newModules = modules
//          .filter { courseModules.contains($0) }
//
//        courseModules.append(objectsIn: newModules)
//      }
//    } catch let err {
//      // Implement error catching
//    }
  }
  
  
}
