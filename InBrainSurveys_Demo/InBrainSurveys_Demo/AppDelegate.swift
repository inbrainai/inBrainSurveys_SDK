//
//  AppDelegate.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 4/15/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    //InBrain SDK works in portrait mode only.
    //If the app doesn't support portrait mode -
    //needs to enable it for InBrain SDK.
    
    /*
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    
        var orientation: UIInterfaceOrientationMask = [.landscapeLeft, .landscapeRight]
        
        if InBrain.shared.isOnScreen {
            return orientation.insert(.portrait).memberAfterInsert
        }
        
        return orientation
    }
   */
}

