//
//  User.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
  @objc dynamic var firstName: String = ""
  @objc dynamic var lastName: String = ""
  @objc dynamic var avatarUrl: String = ""
  @objc dynamic var contactUid: String = ""
  var courses = List<Course>()
  
  override static func primaryKey() -> String? {
    return "contactUid"
  }
  
}
