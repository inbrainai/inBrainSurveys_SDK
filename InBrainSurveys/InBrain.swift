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
    var webVC = InBrainWebViewController()
    
    public override init() {
        super.init()
        webVC.webView.navigationDelegate = self
        naviController.viewControllers = [webVC]
    }
    
    func constructWebView() {
        
        
    }
    
    public func presentInBrainWebView() {
        UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
            <#code#>
        })
    }
    
    public func setAPICredentials(withClientID: String, andClientSecret: String) {
        //Form JavaScript method setAPIKeys({"client_ID": withClientID, "client_secret": andClientSecret})
        let contentController = WKUserContentController()
        let scriptSource = "setAPIKeys({\"client_ID\": \(withClientID), \"client_secret\": \(andClientSecret)});"
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        contentController.addUserScript(script)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        //Serve up JavaScript method to webVC.webView
        webVC.webView.configuration.userContentController.addUserScript(script)
        
    }
    
    public func setInBrainUser(withAppUID: String) {
        //Form JavaScript method setUser({"device_id": havingDeviceID, "app_uid": andAppUID})
        let contentController = WKUserContentController()
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        let scriptSource = "setAPIKeys({\"device_id\": \(String(describing: deviceID)), \"app_uid\": \(withAppUID)});"
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        contentController.addUserScript(script)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        //Serve up JavaScript method to webVC.webView
        webVC.webView.configuration.userContentController.addUserScript(script)
    }
    
    //MARK: WKScriptDelegate method
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //
    }
}


