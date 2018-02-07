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

class CourseViewModel: ViewModel {
  // MARK: Public Variables
  var coordinator: Coordinator
  var update: () -> Void
  
  init(coordinator: Coordinator, updateFunction: @escaping () -> Void) {
    self.coordinator = coordinator
    self.update = updateFunction
  }

  var title: String {
    return course.title
  }
  
  var professor: String {
    return course.professorName
  }
  
  var dateRange: String {
    return "\(course.startOn) - \(course.endOn)"
  }
  
  var headerImage: URL? {
    return course.institutionLogoUrl
  }
  
  var navbarTitle: String {
    return user.firstName.isEmpty ? "" : "Welcome Back, \(user.firstName)!"
  }

  
  // MARK: - Private Variables
  fileprivate let courseManager = CourseManager()
  fileprivate var persistedCourses = Realm.shared.objects(Course.self)
  fileprivate var users = Realm.shared.objects(User.self)
  
  fileprivate var user: User {
    return users.first ?? User()
  }
  
  fileprivate var course: Course {
    return persistedCourses.first ?? Course()
  }
  
  fileprivate var modules: List<Module> {
    return course.courseModules.filter { $0.segments.count > 0 }
  }
  
  
  // MARK: - Public Methods

  
  func retrieveCourse() {
    courseManager.retrieveCourse().finally { [weak self] in
      guard let this = self else { fatalError() }
      this.update()
    }
  }

  func didSelectLectureSegment(module: Int, Index: Int) {
    let courseId = course.id
    let selectedSegment = segment(module: module, index: Index)
    let id = selectedSegment.id
    transitionToLectureScreen(courseId: courseId, id: id)
  }
  
  private func transitionToLectureScreen(courseId: Int, id: Int) {
    OperationQueue.main.addOperation { [weak self] in
      guard let this = self else { fatalError() }
      this.coordinator.push(scene: Scene.lecture(courseId: courseId, id: id))
    }
  }
}

// MARK: - UITableView Datasource
extension CourseViewModel {
  
  var numberOfModules: Int {
    return modules.count
  }
  
  func numberOfSegments(module: Int) -> Int {
    return modules[module].segments.count
  }
  
  func segment(module: Int, index: Int) -> LectureSegment {
    return modules[module].segments[index]
  }
  
  func moduleLabel(for index: Int) -> String {
    return modules[index].title
  }
}
