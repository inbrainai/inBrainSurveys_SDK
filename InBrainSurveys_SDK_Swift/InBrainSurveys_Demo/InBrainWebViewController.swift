//
//  InBrainWebViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 5/31/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import UIKit
import WebKit

//protocol InBrainWebViewDelegate {
//
//}

class InBrainWebViewController: UIViewController {
    //    var webDelegate : InBrainWebViewDelegate?
    static let configurationURLStaging = "https://inbrainwebview-staging.azureedge.net"
    static let configurationURLProd = "https://www.surveyb.in"
    static let clientIDKey = "InBrain_clientID"
    static let clientSecretKey = "InBrain_clientSecret"
    
    let c_ID : String
    let c_secret : String
    let appUID : String
    var surveyWebview : WKWebView?
    
    init(appUserID: String) {
        c_ID = Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.clientIDKey) as! String
        c_secret = Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.clientSecretKey) as! String
        appUID = appUserID
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
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        guard let devID = deviceID else { return }
        let dict : [String : Any] = [
            "client_id":c_ID,
            "client_secret": c_secret,
            "device_id": devID,
            "app_uid": appUID
        ]
        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let jsonString = String(data: json, encoding: String.Encoding.utf8)
        guard let jsonStr = jsonString else { return }
        let scriptSource = "setConfiguration(\(jsonStr));"
        //        print(scriptSource)
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "surveyOpened")
        contentController.add(self, name: "surveyClosed")
        contentController.addUserScript(script)
        print(contentController)
        config.userContentController = contentController
//        config.userContentController.addUserScript(script)
//        print(config)
        print(dict)
        
        surveyWebview = WKWebView(frame: view.bounds, configuration: config)
        
        if let survWebV = surveyWebview {
            //            survWebV.navigationDelegate = self
            view.addSubview(survWebV)
            title = "inBrain"
            if let url = URL(string: InBrainWebViewController.configurationURLStaging) {
                print(url)
                survWebV.load(URLRequest(url: url))
            }
        }
    }
    
    @objc func dismissNavi() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension InBrainWebViewController : WKScriptMessageHandler{
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "surveyClosed" {
            //Change the Navigation Back button with a different URL loading to the WKWebView
            self.navigationItem.leftBarButtonItem = nil
            //Possibly set a instance variable to hold the next URL string value
            let backButton = UIBarButtonItem(title:"Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBackTo))
            self.navigationItem.leftBarButtonItem = backButton
            //            let dict = message.body as? NSDictionary {
            //                geocodeAddress(dict: dict)
            //            }
        } else if message.name == "surveyOpened" {
            //Change the Navigation Back button with a different URL loading to the WKWebView
            self.navigationItem.leftBarButtonItem = nil
            //Possibly set a instance variable to hold the next URL string value
            let backButton = UIBarButtonItem(title:"Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBackTo))
            self.navigationItem.leftBarButtonItem = backButton
            //            let dict = message.body as? NSDictionary {
            //                geocodeAddress(dict: dict)
            //            }
        }
    }

    @objc func goBackTo() {
        if let survWebV = surveyWebview, let url = URL(string: InBrainWebViewController.configurationURLStaging)  {
            survWebV.load(URLRequest(url: url))
            self.navigationItem.leftBarButtonItem = nil
            let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
            self.navigationItem.leftBarButtonItem = backButton
        }
    }
}
