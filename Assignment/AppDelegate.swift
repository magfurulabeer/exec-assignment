//
//  AppDelegate.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/4/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import Moya
import KeychainAccess
import then
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var coordinator: Coordinator!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let config = Realm.Configuration(
      schemaVersion: 7,
      
      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < 7) {}
    })
    
    // Tell Realm to use this new configuration object for the default Realm
    Realm.Configuration.defaultConfiguration = config
    
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    
    if window == nil {
      window = UIWindow(frame: UIScreen.main.bounds)
      window!.tintColor = UIColor.white

    }
    
    coordinator = Coordinator(window: window!)
    
    let realm = try! Realm()
    if realm.objects(User.self).first != nil {
      coordinator.root(scene: Scene.course)
//      if window == nil {
//        window = UIWindow(frame: UIScreen.main.bounds)
//      }
//
//      let storyboard = UIStoryboard(name: "App", bundle: Bundle.main)
//      let viewController = storyboard.instantiateInitialViewController()!
//      window!.rootViewController = viewController
//      window!.makeKeyAndVisible()
    } else {
      coordinator.root(scene: Scene.login)
//      let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
//      let viewController = storyboard.instantiateInitialViewController()!
//      window!.rootViewController = viewController
//      window!.makeKeyAndVisible()
    }
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

