//
//  User.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object, Mappable {
  
  // MARK: - Properties
  @objc dynamic var firstName: String = ""
  @objc dynamic var lastName: String = ""
  @objc dynamic var avatarUrl: String = ""
  @objc dynamic var contactUid: String = ""
  var courses = List<Course>()
  
  override static func primaryKey() -> String? {
    return "contactUid"
  }
  
  // MARK: - Initializers
  required convenience init?(map: Map) {
    self.init()
  }
  
  // MARK: - Mapping
  
  func mapping(map: Map) {
    firstName <- map["first_name"]
    lastName <- map["last_name"]
    avatarUrl <- map["avatar_url"]
    contactUid <- map["sf_contact_uid"]
  }
}


