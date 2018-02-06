//
//  LectureFile.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class LectureFile: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var file: String = ""
  
  var fileUrl: URL? {
    return URL(string: file)
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
    file <- map["file"]
  }
}
