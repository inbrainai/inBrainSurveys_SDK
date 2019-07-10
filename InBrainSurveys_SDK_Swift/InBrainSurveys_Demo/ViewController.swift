//
//  ViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 4/15/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import InBrainSurveys_SDK_Swift

class ViewController: UIViewController, InBrainDelegate {
    
//    static let configurationURL = "https://www.surveyb.in/configuration"
    var surveyWebview : WKWebView?
    static let stagingKey = "zTtQV9gX@P+Bs6vW72v%cz=8SZcXP#Mw"
    static let prodKey = "#wca=fXgVzgNwK&9tJ*$QLa%v*yQa^7%"
//    var viewController : InBrainWebViewController?
    let inBrain : InBrain = InBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        inBrain.rewardDelegate = self
        /*** IF this were called in a normal AppDelegate, AppDidFinishLaunching scenario
        InBrain.setAPICredentials(withClientID: "ID@MyBank", andClientSecret: "RSC")
        InBrain.setInBrainUser(withAppUID: "ThankfulForHisBlessins")
         ***/
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func inBrainRewardsReceived(rewardsArray: [InBrainReward]) {
        print("Miracle")
        var arr : [Int] = []
        for reward in rewardsArray {
            if let txID = reward.transactionId {
                arr.append(txID)
            }
        }
        inBrain.confirmRewards(txIdArray: arr)
    }

    @IBAction func showInBrain(_ sender: Any) {
        inBrain.setInBrainWebViewNavBarColor(toColor: UIColor.green)
        inBrain.setInBrainWebViewTitle(toString: "Little Surveys")
        inBrain.setInBrainWebViewNavButtonColor(toColor: UIColor.yellow)
        inBrain.presentInBrainWebView(withAppUID: "")
       
        //        InBrain.presentInBrainWebView(withClientID: "external-web-client", clientSecret: ViewController.stagingKey, andAppUID: "jie@atp.co")
//        InBrain.presentInBrainWebView(withAppUID: "tes@test.com")
        //MARK: Refactor Testing of Framework Components
//        let naviController = UINavigationController()
//        viewController = InBrainWebViewController(appUserID: "zraan@ap.com")
//        if let vc = viewController {
//            surveyWebview = viewController?.surveyWebview
//            naviController.viewControllers = [vc]
//            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: nil)
//            if let surWebView = surveyWebview {
//                naviController.viewControllers = [vc]
//                UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: nil)
//            }
//        }
        
//        let config = WKWebViewConfiguration()
//        //        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
//        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        guard let devID = deviceID else { return }
//        let dict : [String : Any] = [
//            "client_id": "external-web-client",
//            "client_secret": ViewController.stagingKey,
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
//        let contentController = WKUserContentController()
//        contentController.add(ViewController.viewController, name: "JAVASCRIPTFUNCTION")
//        config.userContentController = contentController
//
//        surveyWebview = WKWebView(frame: ViewController.viewController.view.bounds, configuration: config)
//
//        //        surveyWebview = WKWebView(frame: vc.view.bounds)
//        if let survWebV = surveyWebview {
//            //            survWebV.navigationDelegate = self
//            ViewController.viewController.view.addSubview(survWebV)
//            ViewController.viewController.title = "inBrain"
//            let naviController = UINavigationController()
//            naviController.viewControllers = [ViewController.viewController]
//            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
//                if let url = URL(string: ViewController.configurationURLStaging) {
//                    print(url)
//                    survWebV.load(URLRequest(url: url))
//                }
//            })
//        }
        
    }
    
    @objc func dismissNavi() {
        dismiss(animated: true, completion: nil)
    }
    
}

