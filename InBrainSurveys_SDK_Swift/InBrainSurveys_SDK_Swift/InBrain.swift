//
//  InBrain.swift
//  InBrainSurveys
//
//  Created by Joel Myers on 4/2/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation
import WebKit
import UIKit

fileprivate enum InBrainPayoutType : Int {
    case PayoutComplete = 0
    case UserDidntQualify = 1
    case BonusPayout = 2
    case CampaignComplete = 3
}

public final class InBrain : NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    var naviController = UINavigationController()
    static var webVC = InBrainWebViewController()
    
    override init() {
        super.init()
        InBrain.webVC.webView.navigationDelegate = self
    }
    
    public class func presentInBrainWebView() {
        let naviController = UINavigationController()
        let webVC = InBrainWebViewController()
        naviController.viewControllers = [webVC]

        UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: nil)
    }
    
    public class func setAPICredentials(withClientID: String, andClientSecret: String) {
        //Form JavaScript method setAPIKeys({"client_ID": withClientID, "client_secret": andClientSecret})
//        let contentController = WKUserContentController()
        
//        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentStart, forMainFrameOnly: true)
//        contentController.addUserScript(script)
        let scriptSource = "setAPIKeys({\"client_ID\": \(withClientID), \"client_secret\": \(andClientSecret)});"
        webVC.webView.evaluateJavaScript(scriptSource) { (result, error) in
            if let result = result {
                print(result)
            }
        }
        
//        let config = WKWebViewConfiguration()
//        config.userContentController = contentController
//        //Serve up JavaScript method to webVC.webView
//        webVC.webView.configuration.userContentController.addUserScript(script)
    }
    
    class func setInBrainUser(withAppUID: String) {
        //Form JavaScript method setUser({"device_id": havingDeviceID, "app_uid": andAppUID})
//        let contentController = WKUserContentController()
        
//        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentStart, forMainFrameOnly: true)
//        contentController.addUserScript(script)
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        let scriptSource = "setAPIKeys({\"device_id\": \(String(describing: deviceID)), \"app_uid\": \(withAppUID)});"
        webVC.webView.evaluateJavaScript(scriptSource) { (result, error) in
            if let result = result {
                print(result)
            }
        }
        
//        let config = WKWebViewConfiguration()
//        config.userContentController = contentController
//        //Serve up JavaScript method to webVC.webView
//        webVC.webView.configuration.userContentController.addUserScript(script)
    }
    
    //MARK: WKScriptDelegate method
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //
    }
}


