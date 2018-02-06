//
//  CourseViewModel.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/6/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import RealmSwift
import then

class CourseViewModel {
  // MARK: Public Variables
  
  var update: () -> Void = {
    print("===== UPDATE BLOCK SHOULD BE REPLACES =====")
  }
  
  var title: String {
    return course.title
  }
  
  var professor: String {
    return "This should come from Course Model. Update Realm!"
  }
  
  var dateRange: String {
    return "\(course.startOn) - \(course.endOn)"
  }
  
  var headerImage: UIImage {
    return UIImage()
    // TODO: Use Kingfisher
//    guard let url = URL(string: course.institutionLogo),
//      let image = UIImage(
  }
  
  var numberOfModules: Int {
    return course.courseModules.count
  }
  
  // MARK: - Private Variables
  private let courseManager = CourseManager()
  var persistedCourses = Realm.shared.objects(Course.self)
  var course: Course {
    return persistedCourses.first ?? Course()
  }
  
  
  // MARK: - Public Methods
  func numberOfSegments(module: Int) -> Int {
    return course.courseModules[module].segments.count
  }
  
  func moduleLabel(for index: Int) -> String {
    return course.courseModules[index].label
  }
  
  func segment(module: Int, index: Int) -> LectureSegment {
    return course.courseModules[module].segments[index]
  }
  
  func retrieveCourse() {
    courseManager.retrieveCourse().finally { [weak self] in
      guard let this = self else { fatalError() }
      this.update()
    }
  }
  
  
//  // MARK: - Public Variables
//  var email: String = ""
//  var password: String = ""
//
//  var buttonIsEnabled: Bool {
//    return emailIsValid && passwordIsValid
//  }
//
//  // MARK: - Private Variables
//  private let authenticationManager = AuthenticationManager()
//
//  private var emailIsValid: Bool {
//    let isLongEnough = email.count >= 8
//    return isLongEnough// && containsEmailSymbols
//  }
//  private var passwordIsValid: Bool {
//    let isLongEnough = password.count >= 8
//    return isLongEnough// && containsMixedCase
//  }
//
//  // Methods
//
//  public func login() {
//    authenticationManager.login(email: email, password: password)
//      .finally(transitionToCourseScreen)
//  }
//
//  private func transitionToCourseScreen() {
//    let storyboard = UIStoryboard(name: "App", bundle: Bundle.main)
//    let viewController = storyboard.instantiateInitialViewController()!
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    appDelegate.window!.rootViewController = viewController
//    appDelegate.window!.makeKeyAndVisible()
//  }
}
