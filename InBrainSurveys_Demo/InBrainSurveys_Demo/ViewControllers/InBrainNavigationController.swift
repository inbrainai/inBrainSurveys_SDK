//
//  InBrainNavigationController.swift
//  InBrainSurveys_Demo
//
//  Created by Sergey Blazhko on 10.06.2021.
//  Copyright © 2021 InBrain. All rights reserved.
//

import UIKit

//iOS 15 nav bar translucent workaround
class InBrainNavigationController: UINavigationController {
    private var kvoToken: NSKeyValueObservation?
    
    deinit {
        kvoToken?.invalidate()
    }
    
    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        super.setNavigationBarHidden(hidden, animated: animated)
        
        if #available(iOS 15.0, *) { setImageViewHidden(hidden) }
    }
}

//MARK: - iOS 15 background imageView alpha workaround

private extension InBrainNavigationController {
    var backgroundImageView: UIImageView? {
        let subviews = navigationBar.subviews
       
        guard !subviews.isEmpty, let backgroundView = subviews.first(where: {
                  String(describing: type(of: $0)).contains("UIBarBackground")
              }) else { return nil }
        
        for view in backgroundView.subviews {
            if let imageView = view as? UIImageView { return imageView }
        }
        
        return nil
    }

    func setImageViewHidden(_ hidden: Bool) {
        kvoToken?.invalidate()
        guard !hidden, let backgroundImageView = backgroundImageView else { return }
        
        let targetAlpha: CGFloat = 1
        backgroundImageView.alpha = targetAlpha
        
        kvoToken = backgroundImageView.observe(\.alpha, options: .new, changeHandler: { imageView, change in
            guard targetAlpha != change.newValue else { return }
            backgroundImageView.alpha = targetAlpha
        })
    }
}

private extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
