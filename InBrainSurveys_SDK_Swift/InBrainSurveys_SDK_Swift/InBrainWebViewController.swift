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

protocol InBrainSurveyDelegate {
    func inBrainWebViewOpened(withPlacement: InBrainPlacement)
    func inBrainWebViewDismissed(withPlacement: InBrainPlacement)
}

class InBrainWebViewController : UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        webView.frame = .zero
//        view.addSubview(webView)
//
//        let layoutGuide = view.safeAreaLayoutGuide
//
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
//        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
//        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
//        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
//
        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
        self.navigationItem.leftBarButtonItem = backButton
        
//        if let url = URL(string: InBrainWebViewController.configurationURL) {
//            webView.load(URLRequest(url: url))
//        }
    }
    
    @objc func dismissNavi() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
