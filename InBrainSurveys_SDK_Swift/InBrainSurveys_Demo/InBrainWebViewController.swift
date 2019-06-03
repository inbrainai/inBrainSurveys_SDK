//
//  InBrainWebViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 5/31/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import UIKit

class InBrainWebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title:"Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissNavi))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func dismissNavi() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
