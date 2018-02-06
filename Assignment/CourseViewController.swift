//
//  CourseViewController.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import RealmSwift
import KeychainAccess

class CourseViewController: UIViewController {

  @IBOutlet weak var text: UILabel!
  let courseService = CourseService()
  let userService = UserService()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let realm = try! Realm()
    guard let user = realm.objects(User.self).first else {
      fatalError("No User")
    }
    
    text.text = "Welcome back \(user.firstName)."
  
    let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    userService
      .getUserCourses(userToken: keychain[Constants.Params.userToken]!)
      .then { (course) -> Void in
        print(course.id)
        print("DONE")
      }
//    courseService
//      .getCourse(userToken: )
    
//      .getToken(email: emailTextField.text!, password: passwordTextField.text!)
//      .then(userService.getUser)
//      .finally {
//        OperationQueue.main.addOperation { [weak self] in
//          guard let this = self else { return }
//          this.transitionToCourse()
//        }
    
  }



}
