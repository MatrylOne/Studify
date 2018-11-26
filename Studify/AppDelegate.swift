//
//  AppDelegate.swift
//  Studify
//
//  Created by Jakub Nadolny on 04/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit
import ARKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard ARConfiguration.isSupported == true else {
            fatalError("ARKit nie jest dostępny na tym urządzeniu.")
        }
        
        return true
    }
}

