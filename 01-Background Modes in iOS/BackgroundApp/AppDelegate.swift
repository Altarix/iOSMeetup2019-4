//
//  AppDelegate.swift
//  BackgroundApp
//
//  Created by AikOganisyan on 08/11/2019.
//  Copyright © 2019 icos. All rights reserved.
//

import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.setMinimumBackgroundFetchInterval(60)
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    //MARK:- Fetch
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(#function)
        
        Service.shared.fetchData { result in
            switch result {
            case .succes(let newModel):
                Service.shared.model = newModel
                NotificationCenter.default.post(name: NSNotification.Name("fetchNewData"), object: nil)
                completionHandler(.newData)
            case .noNewData:
                completionHandler(.noData)
            case .error:
                completionHandler(.failed)
            }
        }
    }

}

