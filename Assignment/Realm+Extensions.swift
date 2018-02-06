//
//  Realm+Extensions.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
  
  static let shared: Realm = {
    do {
      return try Realm()
    } catch {
      fatalError("Failed to created share Realm singleton.")
    }
  }()
  
  /////////
  
  class func insert(_ object: Object, update: Bool = false) {
    Realm.write {
      Realm.add(object, update: update)
    }
  }
  
  class func insert<S: Sequence>(_ objects: S, update: Bool = false) where S.Iterator.Element: Object {
    Realm.write {
      Realm.add(objects, update: update)
    }
  }
  
  ///////
  
  class func write(_ block: @escaping (() -> Void)) {
    OperationQueue.main.addOperation {
      do {
        try Realm.shared.write(block)
      } catch let error {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  class func add(_ object: Object, update: Bool = false) {
    OperationQueue.main.addOperation {
      do {
        try Realm.shared.add(object, update: update)
      } catch let error {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  class func add<S: Sequence>(_ objects: S, update: Bool = false) where S.Iterator.Element: Object {
    OperationQueue.main.addOperation {
      do {
        try Realm.shared.add(objects, update: update)
      } catch let error {
        fatalError(error.localizedDescription)
      }
    }
  }
  
//  class func objects<T>(_ type: T.Type) -> Results<T> {
//    OperationQueue.main.addOperation {
//      var results =
//      do {
//        let realm = try Realm()
//        let results = try realm.objects(type)
//        return results
//      } catch let error {
//        fatalError(error.localizedDescription)
//      }
//      
//      
//    }
//  }
  
}

