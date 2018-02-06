//
//  CourseViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import RealmSwift

class CourseViewController: UIViewController {

  @IBOutlet weak var text: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let realm = try! Realm()
    guard let user = realm.objects(User.self).first else {
      fatalError("No User")
    }
    
    text.text = "Welcome back \(user.firstName)."
  
  }



}
