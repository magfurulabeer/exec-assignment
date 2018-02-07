//
//  Coordinator.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/7/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

class Coordinator {
  fileprivate var window: UIWindow
  var currentViewController: UIViewController

  required init(window: UIWindow) {
    self.window = window
    currentViewController = window.rootViewController ?? UIViewController()
  }
  
  static func actualViewController(for viewController: UIViewController) -> UIViewController {
    if let navigationController = viewController as? UINavigationController {
      return navigationController.viewControllers.first!
    } else {
      return viewController
    }
  }
  
  func push(scene: Scene) {
    guard let navigationController = currentViewController.navigationController else {
      fatalError("Can't push a view controller without a current navigation controller")
    }
    
    let viewController = scene.viewController(coordinator: self)
    viewController.navigationItem.hidesBackButton = true
    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "⟵ Back", style: .plain, target: self, action: #selector(pop))
    navigationController.pushViewController(viewController, animated: true)
    currentViewController = Coordinator.actualViewController(for: viewController)
  }
  
  func root(scene: Scene) {
    let viewController = scene.viewController(coordinator: self)
    currentViewController = Coordinator.actualViewController(for: viewController)
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  @objc func pop(animated: Bool = true) {
    if let navigationController = currentViewController.navigationController {
      guard navigationController.popViewController(animated: animated) != nil else {
        fatalError("can't navigate back from \(currentViewController)")
      }
      currentViewController = Coordinator.actualViewController(for: navigationController.viewControllers.last!)
    } else {
      fatalError("No navigation controller: can't navigate back from \(currentViewController)")
    }
  }
}
