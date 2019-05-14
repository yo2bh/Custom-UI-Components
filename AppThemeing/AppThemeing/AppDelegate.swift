//
//  AppDelegate.swift
//  AppThemeing
//
//  Created by Yogesh Bharate on 8/20/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setUpAppIcon()
    
    return true
  }
  
  func setUpAppIcon() {
    // Print BRAND_SETTING name
    delay(0.01) {
      if UIApplication.shared.supportsAlternateIcons,
        let setting = Bundle.main.object(forInfoDictionaryKey: "AppSetting") as? String {
        print(setting)
        self.changeIcon(setting)
      }
      else {
        print("")
      }
    }
  }
  
  func changeIcon(_ icon: String = "blue") {
    UIApplication.shared.setAlternateIconName(icon) { error in
      print(error?.localizedDescription)
    }
  }
  
  func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
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

