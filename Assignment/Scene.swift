//
//  Scene.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/7/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

enum Scene {
  case login
  case course
  case lecture(courseId: Int, id: Int)
}

extension Scene {
  func viewController(coordinator: Coordinator) -> UIViewController {
    // TODO: Consider creating a storyboard enum/struct
    let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
    let appStoryboard = UIStoryboard(name: "App", bundle: nil)
    
    switch self {
    case .login:
      let viewController = loginStoryboard.instantiateInitialViewController() as! LoginViewController
      let viewModel = LoginViewModel(coordinator: coordinator)
      viewController.viewModel = viewModel
      return viewController
      
    case .course:
      let navController = appStoryboard.instantiateInitialViewController() as! UINavigationController
      navController.navigationBar.barTintColor = Constants.Colors.darkRed
      let viewController = navController.viewControllers.first as! CourseViewController // TODO: View Controller identifier extension
      let viewModel = CourseViewModel(coordinator: coordinator, updateFunction: viewController.updateView)
      viewController.viewModel = viewModel
      return navController
      
    case .lecture(let ids):
      let viewController = appStoryboard.instantiateViewController(withIdentifier: "LectureViewController") as! LectureViewController
      // TODO: Consider creating protocol for VMs with coordinator and a protocol for VCs with VM
      let viewModel = LectureViewModel(coordinator: coordinator, update: viewController.updateView, courseId: ids.courseId, id: ids.id)
      viewController.viewModel = viewModel
      return viewController
    }
  }
}
