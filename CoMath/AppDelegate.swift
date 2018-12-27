//
//  AppDelegate.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    WallPost.registerSubclass()
    
    let configuration = ParseClientConfiguration {
      $0.applicationId = "com.StanArts.CompetitiveMath1"
      $0.server = "http://localhost:1337/parse"
    }
    Parse.initialize(with: configuration)
    
    return true
  }
}
