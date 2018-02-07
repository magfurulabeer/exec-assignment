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
  
  var update: () -> Void = {}
  
  var title: String {
    return course.title
  }
  
  var professor: String {
    return course.professorName
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
  

  
  // MARK: - Private Variables
  fileprivate let courseManager = CourseManager()
  fileprivate var persistedCourses = Realm.shared.objects(Course.self)
  var course: Course {
    return persistedCourses.first ?? Course()
  }
  
  var modules: List<Module> {
    return course.courseModules.filter { $0.segments.count > 0 }
  }
  
  // MARK: - Public Methods

  
  func retrieveCourse() {
    courseManager.retrieveCourse().finally { [weak self] in
      guard let this = self else { fatalError() }
      this.update()
    }
  }

//  private func transitionToCourseScreen() {
//    let storyboard = UIStoryboard(name: "App", bundle: Bundle.main)
//    let viewController = storyboard.instantiateInitialViewController()!
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    appDelegate.window!.rootViewController = viewController
//    appDelegate.window!.makeKeyAndVisible()
//  }
}

// MARK: - UITableView Datasource
extension CourseViewModel {
  
  var numberOfModules: Int {
    return modules.count
  }
  
  func numberOfSegments(module: Int) -> Int {
    return modules[module].segments.count
    //    return course.courseModules[module].segments.count
  }
  
  func segment(module: Int, index: Int) -> LectureSegment {
    return modules[module].segments[index]
  }
  
  func moduleLabel(for index: Int) -> String {
    return modules[index].title
  }
}
