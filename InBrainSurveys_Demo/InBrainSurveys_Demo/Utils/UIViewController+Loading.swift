//
//  UIViewController+Loading.swift
//  InBrainSurveys_Demo
//
//  Created by Sergey Blazhko on 07.10.2020.
//  Copyright © 2020 InBrain. All rights reserved.
//

import UIKit

protocol LoadableView {
    func startActivity()
    func stopActivity()
}

extension LoadableView where Self: UIViewController {
    private var activityTag: Int { 0xFF73 }
    private var existingActivity: UIActivityIndicatorView? {
        return view.viewWithTag(activityTag) as? UIActivityIndicatorView
    }

    func startActivity() {
        if let activity = existingActivity {
            activity.startAnimating()
            return
        }
        
        let activity: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activity = UIActivityIndicatorView(style: .large)
        } else {
            activity = UIActivityIndicatorView(style: .whiteLarge)
        }
        
        activity.color = .mainColor
        activity.hidesWhenStopped = true
        activity.startAnimating()
        activity.tag = activityTag
        view.addSubview(activity)

        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func stopActivity() {
        DispatchQueue.main.async {
            guard let existingActivity = self.existingActivity else { return }
            existingActivity.stopAnimating()
        }
    }
}
