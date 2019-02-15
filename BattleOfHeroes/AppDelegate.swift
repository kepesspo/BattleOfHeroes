//
//  AppDelegate.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Reachability
import SpotifyLogin

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let redirectURL: URL = URL(string: "battleofheroes://")!
        
        SpotifyLogin.shared.configure(clientID: "466b1ac50ffb4a2a866dddbeab9bef80",
                                      clientSecret: "43ac2f2354324f90b2ac7699dcae4292",
                                      redirectURL: redirectURL)
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let handled = SpotifyLogin.shared.applicationOpenURL(url) { _ in }
        return handled
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

