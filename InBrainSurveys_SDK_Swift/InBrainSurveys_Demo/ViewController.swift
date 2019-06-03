//
//  ViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 4/15/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation
import UIKit
import InBrainSurveys_SDK_Swift
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
//    static let configurationURL = "https://www.surveyb.in/configuration"
    var surveyWebview : WKWebView?
    static let stagingKey = "zTtQV9gX@P+Bs6vW72v%cz=8SZcXP#Mw"
    static let prodKey = "#wca=fXgVzgNwK&9tJ*$QLa%v*yQa^7%"
    static let viewController = InBrainWebViewController()
    static let configurationURLStaging = "https://inbrainwebview-staging.azureedge.net"
    static let configurationURLProd = "https://www.surveyb.in"

    override func viewDidLoad() {
        super.viewDidLoad()
        /*** IF this were called in a normal AppDelegate, AppDidFinishLaunching scenario
        InBrain.setAPICredentials(withClientID: "ID@MyBank", andClientSecret: "RSC")
        InBrain.setInBrainUser(withAppUID: "ThankfulForHisBlessins")
         ***/
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showInBrain(_ sender: Any) {
        InBrain.presentInBrainWebView(withClientID: "external-web-client", clientSecret: ViewController.stagingKey, andAppUID: "jie@atp.co")
    
//        let config = WKWebViewConfiguration()
//        //        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
//        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        guard let devID = deviceID else { return }
//        let dict : [String : Any] = [
//            "client_id": "external-web-client",
//            "client_secret": ViewController.prodKey,
//            "device_id": devID,
//            "app_uid": "newnuw@atp.co"
//        ]
//        print(dict)
//        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//        let jsonString = String(data: json, encoding: String.Encoding.utf8)
//        guard let jsonStr = jsonString else { return }
//        let scriptSource = "setConfiguration(\(jsonStr));"
//        //        print(scriptSource)
//        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
//        config.userContentController.addUserScript(script)
//        //        config.userContentController.add(self, name: "iosListener")
//
//        surveyWebview = WKWebView(frame: ViewController.viewController.view.bounds, configuration: config)
//        //        surveyWebview = WKWebView(frame: vc.view.bounds)
//        if let survWebV = surveyWebview {
//            //            survWebV.navigationDelegate = self
//            ViewController.viewController.view.addSubview(survWebV)
//            ViewController.viewController.title = "inBrain"
//            let naviController = UINavigationController()
//            naviController.viewControllers = [ViewController.viewController]
//            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
//                if let url = URL(string: ViewController.configurationURLProd) {
//                    print(url)
//                    survWebV.load(URLRequest(url: url))
//                }
//            })
//        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString {
            print("This URL: \(urlString)")
            decisionHandler(.allow)
//            if urlString.range(of: "/Finished?") != nil || urlString.range(of: "/Terminate") != nil  {
//                decisionHandler(.cancel)
//                let vc = Router.viewController(withIdentifier: "surveyEnding", fromStoryboard: "Main") as! SurveyEndingViewController
//                vc.surveyArray = surveyArray
//                present(vc, animated: true, completion: nil)
//                //                self.backButtonPressed()
//            } else {
//                decisionHandler(.allow)
//            }
        }
    }
    
    @objc func dismissNavi() {
        dismiss(animated: true, completion: nil)
    }
    
}

