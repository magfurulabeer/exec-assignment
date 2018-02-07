//
//  LectureSegment.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class LectureSegment: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var label: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var slideShow: String = ""
  @objc dynamic var videoUrlString: String = ""
  @objc dynamic var lectureFileUrlString: String = ""

  var lectureFiles = List<LectureFile>() // TODO: Marked for deletion
  var slides = List<Slide>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  // MARK: - Initializers
  required convenience init?(map: Map) {
    // Only take lecture segments
    if map.JSON["type"] as? String != "ContentLibrary::LectureSegment" {
      print("Segment is not Lecture. It is \(map.JSON["type"] as? String ?? "--Failed--")")
      return nil
    }
    self.init()
  }
  
  // MARK: - Mapping
  
  func mapping(map: Map) {
    print(">> Segment - \(map.JSON["label"] as? String ?? "--Failed--")")
    id <- map["id"]
    label <- map["label"]
    name <- map["name"]
    slideShow <- map["slide_show"]
    videoUrlString <- map["video_url"]
  
    if map.JSON["lecture_files.file"] as? String != nil {
      lectureFileUrlString <- map["lecture_files.file"]
    }
    
    if map.JSON["slides"] as? [JSON] != nil {
      slides <- (map["slides"], ListTransform<Slide>())
    }
  }
}
