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

//protocol InBrainDelegate {
//    func delegateAlerted()
//}

public final class InBrain : NSObject, WKNavigationDelegate {
    static let naviController = UINavigationController()
    static let viewController = InBrainWebViewController()
    static var surveyWebView : WKWebView?
    static let configurationURL = "https://www.surveyb.in/configuration"
//    static let webVC = InBrainWebViewController()
//    static var inBrainDelegate : InBrainDelegate?
    
    override init() {
        super.init()
//        InBrain.webVC.webView.navigationDelegate = self
    }
    
    public class func presentInBrainWebView(withClientID: String, clientSecret: String, andAppUID: String) {
//        let vc = UIViewController()
//        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
//        viewController.navigationItem.leftBarButtonItem = backButton
        let config = WKWebViewConfiguration()
        //        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        guard let devID = deviceID else { return }
        let dict : [String : Any] = [
            "client_id": withClientID,
            "client_secret": "l3!9hrl*olsdfliw#4uJO*f^j4ow8",
            "device_id": devID,
            "app_uid": andAppUID
        ]
        
        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = String(data: json, encoding: String.Encoding.utf8)
        guard let jsonStr = jsonString else { return }
        let scriptSource = "setConfiguration(\(jsonStr));"
//        print(scriptSource)
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
//        config.userContentController.add(self, name: "iosListener")
        
        surveyWebView = WKWebView(frame: viewController.view.bounds, configuration: config)
        //        surveyWebview = WKWebView(frame: vc.view.bounds)
        if let survWebV = surveyWebView {
//            survWebV.navigationDelegate = self
            viewController.view.addSubview(survWebV)
            viewController.title = "inBrain"
            let naviController = UINavigationController()
            naviController.viewControllers = [viewController]
            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
                if let url = URL(string: configurationURL) {
                    survWebV.load(URLRequest(url: url))
                }
            })
        }
    }
    
    public class func presentInBrainWebView(withClientID: String, clientSecret: String, deviceID: String, andAppUID: String) {
        //        let vc = UIViewController()
        //        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
        //        viewController.navigationItem.leftBarButtonItem = backButton
        let config = WKWebViewConfiguration()
        //        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
        //        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        //        guard let devID = deviceID else { return }
        let dict : [String : Any] = [
            "client_id": withClientID,
            "client_secret": clientSecret,
            "device_id": deviceID,
            "app_uid": andAppUID
        ]
        
        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = String(data: json, encoding: String.Encoding.utf8)
        guard let jsonStr = jsonString else { return }
        let scriptSource = "setConfiguration(\(jsonStr));"
        //        print(scriptSource)
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        //        config.userContentController.add(self, name: "iosListener")
        
        surveyWebView = WKWebView(frame: viewController.view.bounds, configuration: config)
        //        surveyWebview = WKWebView(frame: vc.view.bounds)
        if let survWebV = surveyWebView {
            //            survWebV.navigationDelegate = self
            viewController.view.addSubview(survWebV)
            viewController.title = "inBrain"
            let naviController = UINavigationController()
            naviController.viewControllers = [viewController]
            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
                if let url = URL(string: configurationURL) {
                    survWebV.load(URLRequest(url: url))
                }
            })
        }
    }
    
    @objc func dismissNavi() {
        UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}


