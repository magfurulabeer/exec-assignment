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
import ObjectMapper_Realm

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
  // Note: I got lazy here
  @objc dynamic var professorFirstName: String = ""
  @objc dynamic var professorLastName: String = ""

  var courseModules = List<Module>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var institutionLogoUrl: URL? {
    return URL(string: institutionLogo)
  }
  
  var professorName: String {
    return "\(professorFirstName) \(professorLastName)"
  }
  
  // MARK: - Initializers
  required convenience init?(map: Map) {
    self.init()
  }
  
  // MARK: - Mapping
  
  func mapping(map: Map) {
    print(">> Course - \(map.JSON["label"] as? String ?? "--Failed--")")
    id                  <- map["id"]
    progress            <- map["progress"]
    currentSegment      <- map["currentSegment"]
    currentModule       <- map["currentModule"]
    studentStatus       <- map["student_status"]
    canSkipAround       <- map["can_skip_around"]
    appCompatible       <- map["app_compatible"]
    startOn             <- map["start_on"]
    endOn               <- map["end_on"]
    title               <- map["title"]
    courseModules       <- (map["course_modules"], ListTransform<Module>())
    professorFirstName  <- map["professors.0.first_name"]
    professorLastName   <- map["professors.0.last_name"]
    institutionLogo     <- map["institution_logo"]
  } 
}
