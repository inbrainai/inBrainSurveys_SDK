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
    var webView = WKWebView()
    
}
