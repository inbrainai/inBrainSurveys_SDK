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
    static let configurationURL = "https://www.surveyb.in/configuration"
    var surveyWebview : WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        /*** IF this were called in a normal AppDelegate, AppDidFinishLaunching scenario
        InBrain.setAPICredentials(withClientID: "ID@MyBank", andClientSecret: "RSC")
        InBrain.setInBrainUser(withAppUID: "ThankfulForHisBlessins")
         ***/
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showInBrain(_ sender: Any) {
        InBrain.presentInBrainWebView(withClientID: "external-web-client", clientSecret: "l3!9hrl*olsdfliw#4uJO*f^j4ow8", andAppUID: "jole@atp.co-0000")
        
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

