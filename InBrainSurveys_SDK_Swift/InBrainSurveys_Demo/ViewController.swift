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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        InBrain.setAPICredentials(withClientID: "ID@MyBank", andClientSecret: "RSC")
        InBrain.setInBrainUser(withAppUID: "ThankfulForHisBlessins")
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showInBrain(_ sender: Any) {
        InBrain.presentInBrainWebView()

    }
    
}

