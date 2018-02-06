//
//  Slide.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Slide: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var id: Int = 0
  @objc dynamic var image: String = ""
  @objc dynamic var startAt: Int = 0
  // Note: If I knew the slide types then maybe I could make Slide subclasses instead
  @objc dynamic var slideType: String = ""
  @objc dynamic var content: String? = nil
  @objc dynamic var iframeArchive: String? = nil
  
  var imageUrl: URL? {
    return URL(string: image)
  }
  
  var iframeArchiveUrl: URL? {
    return URL(string: iframeArchive ?? "")
  }
  
  // MARK: - Realm Methods

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
    image <- map["image"]
    startAt <- map["start_at"]
    slideType <- map["slide_type"]
    content <- map["content"]
    iframeArchive <- map["iframe_archive.url"]
  }
}
