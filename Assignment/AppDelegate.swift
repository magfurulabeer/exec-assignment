//
//  AppDelegate.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/4/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit
import Moya
import Freddy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    func reversedPrint(_ separator: String, terminator: String, items: Any...) {
      for item in items {
        print(item, separator: separator, terminator: terminator)
      }
    }
    
    let provider = MoyaProvider<ExecOnlineAPI>(plugins: [NetworkLoggerPlugin(verbose: true, cURL: true, output: reversedPrint, responseDataFormatter: nil)])
    provider.request(.requestToken(email: "abeer@execonline.com", password: "test12345")) { result in
      
      switch result {
      case .success(let response):
        let data = response.data
        print("Successfully recieved token with \(response.statusCode) code.")
        
        do {
          let json = try JSON(data: data)
          
//          let token = try json.getString(at: "token")
          print("*************")
          print(json)
          print("*************")
        } catch {
          print("Failed to parse JSON")
        }
        
        return
      case .failure(let error):
        print(error.errorDescription)
        print(error.failureReason)
        print(error.localizedDescription)
        fatalError("Error when requesting User Token")
      }
      


    
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

