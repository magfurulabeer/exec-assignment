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

class LectureSegment: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var label: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var slideShow: String = ""
  @objc dynamic var videoUrlString: String = ""

  var lectureFiles = List<LectureFile>()
  var slides = List<Slide>()
  var courses = List<Course>()
  
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
    label <- map["label"]
    name <- map["name"]
    slideShow <- map["slide_show"]
    videoUrlString <- map["video_url"]

    // Lecture Files
    if let lectureFilesData = map.JSON["lecture_files"] as? [JSON]  {
      for data in lectureFilesData {
        if let lectureFile = Mapper<LectureFile>().map(JSON: data) {
          do {
            let realm = try Realm()
            try realm.write {
              realm.add(lectureFile, update: true)
            }
            
            if !lectureFiles.contains(lectureFile) {
              lectureFiles.append(lectureFile)
            }
          } catch let err {
            // Implement error catching
          }
        }
      }
    }
    
    
    
    // Slides
    if let slidesData = map.JSON["slides"] as? [JSON] {
      for data in slidesData {
        if let slide = Mapper<Slide>().map(JSON: data) {
          do {
            let realm = try Realm()
            try realm.write {
              realm.add(slide, update: true)
            }
            
            if !slides.contains(slide) {
              slides.append(slide)
            }
          } catch let err {
            // Implement error catching
          }
        }
      }
    }
    
  }
}
