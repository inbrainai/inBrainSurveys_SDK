//
//  InBrain.swift
//  InBrainSurveys
//
//  Created by Joel Myers on 4/2/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation
import WebKit

fileprivate enum InBrainPayoutType : Int {
    case PayoutComplete = 0
    case UserDidntQualify = 1
    case BonusPayout = 2
    case CampaignComplete = 3
}

public final class InBrain : NSObject, WKNavigationDelegate {
    var webVC = InBrainWebViewController()
    
    public override init() {
        super.init()
        webVC.webView.navigationDelegate = self
    }
    
    public func presentInBrainWebView() {
        
    }
    
    public func setAPICredentials(withClientID: String, andClientSecret: String) {
        //Form JavaScript method setAPIKeys({"client_ID": withClientID, "client_secret": andClientSecret})
        
        //Serve up JavaScript method to webVC.webView
    }
    
    public func setInBrainUser(withDeviceID: String, andAppUID: String) {
        //Form JavaScript method setUser({"device_id": havingDeviceID, "app_uid": andAppUID})
        
        //Serve up JavaScript method to webVC.webView
    }
}


