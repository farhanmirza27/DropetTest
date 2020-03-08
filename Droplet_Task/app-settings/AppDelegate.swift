//
//  AppDelegate.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setupNavBar()
        let loginModule = LoginRouter.createModule()
        window?.rootViewController =  UINavigationController(rootViewController: loginModule)  
        
        return true
    }
    
    func setupNavBar() {
           // Nav-Bar
           UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = .black
           UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont(name: FontName.Medium, size: 16)!]
       }

}
