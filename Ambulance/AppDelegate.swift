//
//  AppDelegate.swift
//  Ambulance
//
//  Created by Imac on 29/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import KeychainSwift
import Firebase


var googleAPIKey1 = "AIzaSyCFudi7Ajot7iwgn6YvK3QwJAno2LJD3Y4"
var Token = String()
var keychain = KeychainSwift()
var web_url = "http://ambulance.test-dewinter.com/api"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
         GMSServices.provideAPIKey(googleAPIKey1)
        
        let lauchedbefore = UserDefaults.standard.bool(forKey: "lauchedBefore")
        
        if lauchedbefore {
            
            print("cbon")
            
        }else {
            
            UserDefaults.standard.set(true, forKey: "lauchedBefore")
            keychain.clear()
            
        }
        
        FirebaseApp.configure()
       //keychain.delete("MyTokenDriver")
        
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

