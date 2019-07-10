//
//  InBrainWebViewController.swift
//  InBrainSurveys
//
//  Created by Joel Myers on 4/2/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation
import UIKit
import WebKit

internal protocol InBrainWebViewDelegate : AnyObject {
    func callGetRewards()
    func webViewDismissed()
}

internal class InBrainWebViewController : UIViewController {
    
    static let configurationURLStaging = "https://inbrainwebview-staging.azureedge.net"
    static let configurationURLProd = "https://www.surveyb.in"
    static let clientIDKey = "InBrain_client"
    static let clientSecretKey = "InBrain_secret"
    static let server2ServerKey = "InBrain_server"
    
    static let prodClientID = "zap-surveys-ios"
    static let prodClientSecret = "V.)beXT}x^M5e)r4!42MK+fh5&TC8~"
    
    let c_ID : String
    let c_secret : String
    let appUID : String
    var surveyWebview : WKWebView?
    weak var webViewDelegate : InBrainWebViewDelegate?
    let isServerToServer : Bool
    
    init(appUserID: String) {
        c_ID = Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.clientIDKey) as! String
        c_secret = Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.clientSecretKey) as! String
        appUID = appUserID
        isServerToServer = Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.server2ServerKey) as! Bool
        super.init(nibName: nil, bundle: nil)
        configureWebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureWebView()
        
        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func configureWebView() {
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "surveyOpened")
        config.userContentController.add(self, name: "surveyClosed")
        config.userContentController.add(self, name: "toggleNativeButtons")
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        guard let devID = deviceID else { return }
        var dict : [String : Any]
        if appUID.isEmpty {
            dict = [
                "client_id":c_ID,
                "client_secret": c_secret,
                "device_id": devID,
                "app_uid": devID
            ]
        } else {
            dict = [
                "client_id":c_ID,
                "client_secret": c_secret,
                "device_id": devID,
                "app_uid": appUID
            ]
        }
        
        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = String(data: json, encoding: String.Encoding.utf8)
        guard let jsonStr = jsonString else { return }
        let scriptSource = "setConfiguration(\(jsonStr));"

        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        
        if (UIDevice().type == .iPhoneX || UIDevice().type == .iPhoneXS || UIDevice().type == .iPhoneXR || UIDevice().type == .iPhoneXSMax || UIDevice().type == .iPadPro12_9) {
            var rectFrame : CGRect?
            rectFrame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height + 34.0)
            if let rect = rectFrame {
                surveyWebview = WKWebView(frame: rect, configuration: config)
            }
        } else {
            surveyWebview = WKWebView(frame: view.bounds, configuration: config)
        }
        
        if let survWebV = surveyWebview {
            view.addSubview(survWebV)
//            title = "inBrain"
            
            if let url = URL(string: InBrainWebViewController.configurationURLStaging) {
                survWebV.load(URLRequest(url: url))
            }
        }
    }
    
    @objc func dismissNavi() {
        webViewDelegate?.webViewDismissed()
    }
    
}

extension InBrainWebViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "surveyOpened" {
            navigationItem.leftBarButtonItem = nil
            let backButton = UIBarButtonItem(title:"Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBackTo))
            navigationItem.leftBarButtonItem = backButton
        } else if message.name == "surveyClosed" {
            navigationItem.leftBarButtonItem = nil
            let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
            navigationItem.leftBarButtonItem = backButton
            //MARK: S2S Bool flag conditionally enables this getRewards timed function
            if !isServerToServer {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self] (timer) in
                    DispatchQueue.global(qos: .background).async {
                        self?.webViewDelegate?.callGetRewards()
                    }
                })
            }
        } else if message.name == "toggleNativeButtons" {
            guard let dict = message.body as? [String : Any] else { return }
            guard let val = dict["message"] as? String else { return }
            if val == "true" {
                navigationItem.leftBarButtonItem = nil
                let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
                navigationItem.leftBarButtonItem = backButton
                //MARK: S2S Bool flag conditionally enables this getRewards timed function
                if !isServerToServer {
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self] (timer) in
                        DispatchQueue.global(qos: .background).async {
                            self?.webViewDelegate?.callGetRewards()
                        }
                    })
                }
            } else if val == "false" {
                navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    @objc func goBackTo() {
        if let survWebV = surveyWebview, let url = URL(string: InBrainWebViewController.configurationURLStaging)  {
            survWebV.load(URLRequest(url: url))
            navigationItem.leftBarButtonItem = nil
            let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
            navigationItem.leftBarButtonItem = backButton
        }
    }
}
