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

public protocol InBrainDelegate : AnyObject {
    /***
     @method inBrainRewardsReceived
     @abstract Delegate function that allows your app to receive InBrainRewards from InBrain service
     @param rewardsArray -> function receives an array of InBrainReward structs to be processed in your app
     ***/
    func inBrainRewardsReceived(rewardsArray: [InBrainReward])
}

/***
Main interface for you to communicate with the InBrain service.
 ***/
public class InBrain : NSObject, InBrainWebViewDelegate {
    public static var shared = InBrain()
    var naviController = UINavigationController()
    var viewController : InBrainWebViewController?
    var survWebView : WKWebView?
    var jsonDecoder: JSONDecoder?
    var brainToken : InBrainToken?
    public var rewardDelegate : InBrainDelegate?
    let isServerToServer : Bool = Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.server2ServerKey) as! Bool
    var titleString : String?
    var navBarColor : UIColor?
    var navFontColor : UIColor?

    //MARK: Environment URLs
    static let brainTokenURL = "https://inbrain-auth-staging.azurewebsites.net/connect/token"
    static let scopeValue = "inbrain-api:integration"
    static let grantTypeValue = "client_credentials"
    static let rewardsURL = "https://inbrain-api-staging.azurewebsites.net/api/v1/external-surveys/rewards/"
    static let confirmRewardsURL = "https://inbrain-api-staging.azurewebsites.net/api/v1/external-surveys/confirm-transactions/"
    
    static let prodRewardsURL = "https://api.surveyb.in/api/v1/external-surveys/rewards/"
    static let prodConfirmRewardsURL = "https://api.surveyb.in/api/v1/external-surveys/confirm-transactions/"
    static let prodBrainTokenURL = "https://auth.surveyb.in/connect/token"

    
    public override init() {
        super.init()
        
    }
    //Needs to be called prior to calling -presentInBrainWebView()
    public func setInBrainWebViewTitle(toString: String) {
        titleString = toString
    }
    
    public func setInBrainWebViewNavBarColor(toColor: UIColor) {
        navBarColor = toColor
    }
    
    public func setInBrainWebViewNavButtonColor(toColor: UIColor) {
        navFontColor = toColor
    }
    
    public func presentInBrainWebView(withAppUID: String) {
        viewController = InBrainWebViewController(appUserID: withAppUID)

        if let vc = viewController {
            if let str = titleString {
                vc.title = str
            } else {
                vc.title = "inBrain"
            }

            vc.webViewDelegate = self
            survWebView = vc.surveyWebview
            if UIDevice().type == .iPhoneX || UIDevice().type == .iPhoneXS || UIDevice().type == .iPhoneXR || UIDevice().type == .iPhoneXSMax {
                naviController.edgesForExtendedLayout = [.bottom, .left, .right]
            }
            
            if let col = navBarColor {
                naviController.navigationBar.barTintColor = col
            } else {
                naviController.navigationBar.barTintColor = UIColor.white
            }
            
            if let color = navFontColor {
                naviController.navigationBar.tintColor = color
            }
            
            if let font = UIFont(name: "AvenirNext-DemiBold", size: 17.0) {
                naviController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
            }
            if let font2 = UIFont(name: "AvenirNext-Regular", size: 13.0) {
                naviController.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font2], for: UIControl.State.normal)
            }
            naviController.viewControllers = [vc]
            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: nil)
        }
    }
    
    //This function makes an Authenticated GET request of InBrainRewards and returns an array of Reward structs for SDK Developers to process in their app then confirm the transactions
    public func getRewards() {
        self.jsonDecoder = JSONDecoder()
        //MARK: GET TOKEN FIRST
        guard let tokenUrl = URL(string: InBrain.brainTokenURL) else { return }
        var tokRequest = URLRequest(url: tokenUrl)
        tokRequest.httpMethod = HTTPMethod.post.rawValue
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        guard let devID = deviceID else { return }
        guard let email = viewController?.appUID else { return }

//        guard let email = Container.shared.get(State.self).currentUser.value?.email else { return }
        
        let tokenDict : [String : Any] = [
            "scope": InBrain.scopeValue,
            "grant_type": InBrain.grantTypeValue,
            "client_id": Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.clientIDKey) as! String,
            "client_secret": Bundle.main.object(forInfoDictionaryKey: InBrainWebViewController.clientSecretKey) as! String/*,
             "device_id": devID,
             "app_uid": email*/
        ]
        
        let jString = tokenDict.queryParameters
        //MARK: URLEncode the dictionary above and make sure to encode the @,+,! symbols appropriately
//        let jString = "client_id=external-web-client&client_secret=zTtQV9gX%40P%2BBs6vW72v%25cz%3D8SZcXP%23Mw&grant_type=client_credentials&scope=inbrain-api:integration"
        
        //        let json = try! JSONSerialization.data(withJSONObject: tokenDict, options: .prettyPrinted)
        //        let jsonString = String(data: json, encoding: String.Encoding.utf8)
        //        guard let jsonStr = jsonString else { return }
        tokRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        guard let dictString = jString else { return }
        tokRequest.httpBody = jString.data(using: .utf8)
        print(tokRequest)
        //        tokRequest.httpBody = json
        //        tokRequest.addValue(jString, forHTTPHeaderField: "Authorization")
        
        let configure = URLSessionConfiguration.default
        let session = URLSession(configuration: configure)
        
        let dataTask = session.dataTask(with: tokRequest, completionHandler: { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            do {
                guard let decoder = self.jsonDecoder else { return }
                guard let inBToken = try? decoder.decode(InBrainToken.self, from: responseData) as InBrainToken else {
                    print("error trying to convert data to JSON")
                    return
                }
                print(inBToken)
                self.brainToken = inBToken
                
                //MARK: GET REWARDS WORK
                var urlString = InBrain.rewardsURL
                urlString = urlString + email + "/" + devID
                guard let rewardUrl = URL(string: urlString) else { return }
                var request = URLRequest(url: rewardUrl)
                request.httpMethod = HTTPMethod.get.rawValue
                request.addValue("Bearer \(inBToken.access_token)", forHTTPHeaderField: "Authorization")
                
                let rewardDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    guard let newResponseData = data else {
                        print("Error: did not receive data")
                        return
                    }
                    do {
                        guard let rewards = try? decoder.decode([InBrainReward].self, from: newResponseData) as [InBrainReward] else {
                            print("error trying to convert data to JSON")
                            return
                        }
                        print("\(rewards) for the Rewards Delegate")
                        //MARK: Developers' presenting view controller will receive the InBrain Rewards
                        self.rewardDelegate?.inBrainRewardsReceived(rewardsArray: rewards)
                        //Call rewardDelegate.didReceiveInBrainReward(rewards)
//                        var arr : [Int] = []
//                        for reward in rewards {
//                            if let txID = reward.transactionId {
//                                arr.append(txID)
//                            }
//                        }
//                        self.confirmRewards(txIdArray: arr)
                    }
                })
                rewardDataTask.resume()
            }
        })
        dataTask.resume()
    }
    //MARK: Confirm Rewards
    public func confirmRewards(txIdArray: [Int]) {
        let deviceID = UIDevice.current.identifierForVendor?.uuidString
        guard let devID = deviceID else { return }
        guard let email = viewController?.appUID else { return }
        
        var urlString = InBrain.confirmRewardsURL
        urlString = urlString + email + "/" + devID
        guard let tokenUrl = URL(string: urlString) else { return }
        
        var req = URLRequest(url: tokenUrl)
        req.httpMethod = HTTPMethod.post.rawValue
        guard let toke = self.brainToken else { return }
        req.addValue("Bearer \(toke.access_token)", forHTTPHeaderField: "Authorization")
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: txIdArray, options: .prettyPrinted)
        guard let json = jsonData else { return }
        req.httpBody = json
        
        let configure = URLSessionConfiguration.default
        let session = URLSession(configuration: configure)
        
        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
//            guard let responseData = data else {
//                print("Error: did not receive data")
//                return
//            }
            if let theResponse = response as? HTTPURLResponse {
                switch theResponse.statusCode {
                case 200..<300:
                    print("Confirmation Success")
                default:
                    print("Confirmation Error")
                }
            }
        })
        task.resume()
    }
    
    @objc func dismissNavi() {
        print("dismissal function Called")
        naviController.dismiss(animated: true) {
            if !self.isServerToServer{
                Timer.scheduledTimer(withTimeInterval: 6, repeats: false, block: { (timer) in
                    DispatchQueue.global(qos: .background).async {
                        self.getRewards()
                    }
                })
            }
            if self.survWebView != nil {
                self.survWebView = nil
            }
        }
//        } UIApplication.shared.keyWindow?.rootViewController?.presentedViewController?.navigationController?.dismiss(animated: true, completion: {
//
//        })
    }
    
    //MARK: InBrainWebViewDelegate function for calling getRewards
    func callGetRewards() {
        print("InBrain Begin Get Rewards call")
        getRewards()
    }
    
    func webViewDismissed() {
        print("InBrain Dismissal called")
        dismissNavi()
    }
    
//    public class func presentInBrainWebView(withClientID: String, clientSecret: String, andAppUID: String) {
////        let vc = UIViewController()
////        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
////        viewController.navigationItem.leftBarButtonItem = backButton
//        let config = WKWebViewConfiguration()
//        //        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
//        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        guard let devID = deviceID else { return }
//        let dict : [String : Any] = [
//            "client_id": withClientID,
//            "client_secret": clientSecret,
//            "device_id": devID,
//            "app_uid": andAppUID
//        ]
//
//        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//        let jsonString = String(data: json, encoding: String.Encoding.utf8)
//        guard let jsonStr = jsonString else { return }
//        let scriptSource = "setConfiguration(\(jsonStr));"
////        print(scriptSource)
//        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
//        config.userContentController.addUserScript(script)
////        config.userContentController.add(self, name: "iosListener")
//        //Initialize the InBrainWebView now
////        viewController = InBrainWebViewController(clientID: withClientID,)
//        surveyWebView = WKWebView(frame: viewController.view.bounds, configuration: config)
//        //        surveyWebview = WKWebView(frame: vc.view.bounds)
//        if let survWebV = surveyWebView {
////            survWebV.navigationDelegate = self
//            viewController.view.addSubview(survWebV)
//            viewController.title = "inBrain"
//            let naviController = UINavigationController()
//            naviController.viewControllers = [viewController]
//            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
//                if let url = URL(string: configurationURLStaging) {
//                    survWebV.load(URLRequest(url: url))
//                }
//            })
//        }
//    }
    
//    public class func presentInBrainWebView(withClientID: String, clientSecret: String, deviceID: String, andAppUID: String) {
//        //        let vc = UIViewController()
//        //        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
//        //        viewController.navigationItem.leftBarButtonItem = backButton
//        let config = WKWebViewConfiguration()
//        //        let source = "document.addEventListener('click', function(){ window.webkit.messageHandlers.iosListener.postMessage('click clack!'); })"
//        //        let deviceID = UIDevice.current.identifierForVendor?.uuidString
//        //        guard let devID = deviceID else { return }
//        let dict : [String : Any] = [
//            "client_id": withClientID,
//            "client_secret": clientSecret,
//            "device_id": deviceID,
//            "app_uid": andAppUID
//        ]
//
//        let json = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//        let jsonString = String(data: json, encoding: String.Encoding.utf8)
//        guard let jsonStr = jsonString else { return }
//        let scriptSource = "setConfiguration(\(jsonStr));"
//        //        print(scriptSource)
//        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
//        config.userContentController.addUserScript(script)
//        //        config.userContentController.add(self, name: "iosListener")
//
//        surveyWebView = WKWebView(frame: viewController.view.bounds, configuration: config)
//        //        surveyWebview = WKWebView(frame: vc.view.bounds)
//        if let survWebV = surveyWebView {
//            //            survWebV.navigationDelegate = self
//            viewController.view.addSubview(survWebV)
//            viewController.title = "inBrain"
//            let naviController = UINavigationController()
//            naviController.viewControllers = [viewController]
//            UIApplication.shared.keyWindow?.rootViewController?.present(naviController, animated: true, completion: {
//                if let url = URL(string: configurationURLStaging) {
//                    survWebV.load(URLRequest(url: url))
//                }
//            })
//        }
//    }
}

//extension String {
//    func stringByAddingPercentEncodingForRFC3986() -> String? {
//        let unreserved = "@+!-._~/?%"
//        let allowed = NSMutableCharacterSet.alphanumeric()
//        allowed.addCharacters(in: unreserved)
//        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
//    }
//}

extension Dictionary {
    var queryParameters: String {
        var parts: [String] = []
        var part = ""
        let customAllowedSet =  NSCharacterSet(charactersIn:"!.~^*'();:@&=+$,/?%#[]{}").inverted
        for (key, value) in self {
            let val = "\(value)"
            if val == "inbrain-api:integration" {
                part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              val)
            } else {
                part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: customAllowedSet)!)
            }
            
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
