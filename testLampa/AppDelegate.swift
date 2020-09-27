//
//  AppDelegate.swift
//  testLampa
//
//  Created by Андрей Шевчук on 16.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainBuilder: MainBuilder = MainBuilder()
    
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let mainController = mainBuilder.createMainModule()
    let navigationController = UINavigationController(rootViewController: mainController)
    
    self.window? = UIWindow(frame: UIScreen.main.bounds)
    self.window?.backgroundColor = .white
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
    
    return true
    }
}

