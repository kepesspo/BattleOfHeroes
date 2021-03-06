//
//  AppDelegate.swift
//  BattleOfHeroes
//  Created by Mark on 7/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import Firebase
import FirebaseDatabase
import Reachability
import SpotifyLogin

 @UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachability = Reachability()!
    var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        checkNetwork()
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
    
    
    func checkNetwork() {
        do {
            try reachability.startNotifier()
        } catch  {
            print("Could not start notifier")
        }
        
        // Check Internet Connection
        reachability.whenReachable = { _ in
             GameManagement.sharedInstance.networkWorks = true
            print("Network works")
             
        }
        
        reachability.whenUnreachable = { _ in
            GameManagement.sharedInstance.networkWorks = false
            self.showNetworkErrorPopup()
            //postNotification(name: .deselectGame)
            
        }
        GameManagement.sharedInstance.networkWorks = reachability.isReachable ? true : false
    }
    
    func showNetworkErrorPopup() {
        let networkVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NetworkViewController") as! NetworkViewController
        networkVC.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.topViewController() {
            topController.present(networkVC, animated: true, completion: nil)
            
        }
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NetworkSevice.sharedInstance.getGameRunning { (error, run) in
            if run == 1 && GameManagement.sharedInstance.isSpactate {
                print("No Delete is Run")
            } else {
                NetworkSevice.sharedInstance.gameRunning(isRun: false) { (error) in
                    if error == nil {
                        print("Lock Screen for other player")
                    } else {
                        print("Error Lock Screen for other player ")
                    }
                }
                NetworkSevice.sharedInstance.horseRaceRunning(isRun: false) { (error) in
                    if error == nil {
                        print("Horse race with database work")
                    } else {
                        print("error")
                    }
                }
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}

