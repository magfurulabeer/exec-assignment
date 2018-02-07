//
//  Module.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Module: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var label: String = ""
  @objc dynamic var gatedUntil: String = ""
  var segments = List<LectureSegment>()

  override static func primaryKey() -> String? {
    return "id"
  }
  
  // MARK: - Initializers
  required convenience init?(map: Map) {
    self.init()
  }
  
  // MARK: - Mapping
  
  func mapping(map: Map) {
    print(">> Module - \(map.JSON["label"] as? String ?? "--Failed--")")
    id <- map["course_module_id"]
    title <- map["title"]
    label <- map["label"]
    gatedUntil <- map["gated_until"]
    segments <- (map["segments"], ListTransform<LectureSegment>())
  }

}
