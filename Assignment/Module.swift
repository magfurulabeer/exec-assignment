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

class Module: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var label: String = ""
  @objc dynamic var gatedUntil: String = ""
  var segments = List<LectureSegment>() // Ordered by label alphabetically (1.1 before 1.2)

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
    title <- map["title"]
    label <- map["label"]
    gatedUntil <- map["gated_until"]
    
    // Lecture Segments
    let lectureSegmentsData = map.JSON["segments"] as! [JSON] // TODO: Remove forced cast
    
    let lectureSegments = lectureSegmentsData
      .filter { $0["type"] as? String == "ContentLibrary::LectureSegment" }
      .map { Mapper<LectureSegment>().map(JSON: $0) ?? LectureSegment() }
      .filter { $0.id != 0 } // Check if id can be 0
    
    do {
      let realm = Realm.shared
      try realm.write {
        realm.add(lectureSegments, update: true)
        
        let newSegments = lectureSegments
          .filter { segments.contains($0) }
        
        segments.append(objectsIn: newSegments)
      }
    } catch let err {
      // Implement error catching
    }

   
  }
}
