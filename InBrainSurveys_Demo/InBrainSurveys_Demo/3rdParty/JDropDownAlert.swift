//
//  JDropDownAlert.swift
//
//  Created by Trilliwon on 2016. 4. 21..
//  Copyright (c) 2016 trilliwon <trilliwon@gmail.com> All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public enum AlertPosition {
    case top
    case bottom
}

public enum AnimationDirection {
    case toLeft
    case toRight
    case normal
}

open class JDropDownAlert: UIButton {
    // default values
    // You can change this values to customize
    var height: CGFloat = 70
    var duration = 0.3
    var delay: Double = 2.0

    fileprivate var titleFrame: CGRect!
    fileprivate var topLabel = UILabel()
    fileprivate var messageLabel = UILabel()

    open var position = AlertPosition.top
    open var direction = AnimationDirection.normal

    private var keyWindow: UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
    
    private lazy var statusBarHeight: CGFloat = {
        if #available(iOS 13.0, *) {
            return keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }()
    
    private lazy var screenWidth: CGFloat = {
        if let keyWindow = keyWindow {
            return keyWindow.bounds.size.width
        }
        return UIScreen.main.bounds.size.width
    }()

    private lazy var screenHeight: CGFloat = {
        if let keyWindow = keyWindow {
            return keyWindow.bounds.size.height
        }
        return UIScreen.main.bounds.size.height
    }()

    open var titleFont: UIFont = .boldSystemFont(ofSize: 16) {
        didSet {
            topLabel.font = titleFont
        }
    }

    open var messageFont: UIFont = .systemFont(ofSize: 14) {
        didSet {
            messageLabel.font = messageFont
        }
    }

    open var didTapBlock: (() -> Void)?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public init(position: AlertPosition = .top, direction: AnimationDirection = .normal) {
        super.init(frame: CGRect.zero)

        frame = getFrameBy(position, direction: direction)
        self.direction = direction
        self.position = position
        setDefaults()
    }

    fileprivate func setDefaults() {
        setTitleDefaults()
        setMessageDefaults()
        backgroundColor = UIColor.lightRed()
        addTarget(self, action: #selector(viewDidTap), for: .touchUpInside)
    }

    fileprivate func setTitleDefaults() {
        titleFrame = CGRect(x: 10,
                            y: position == .top ? statusBarHeight : 15,
                            width: frame.size.width - 10,
                            height: 20)

        topLabel = UILabel(frame: titleFrame)
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 10
        topLabel.textColor = UIColor.white
        topLabel.font = titleFont
        addSubview(topLabel)
    }

    fileprivate func setMessageDefaults() {
        let messageFrame: CGRect

        if position == .top {
            messageFrame = CGRect(x: 10, y: statusBarHeight + titleFrame.height + 5, width: frame.size.width - 10, height: 20)
        } else {
            messageFrame = CGRect(x: 10, y: titleFrame.size.height + titleFrame.height, width: frame.size.width - 10, height: 20)
        }
        messageLabel = UILabel(frame: messageFrame)
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 10
        messageLabel.textColor = UIColor.white
        messageLabel.font = messageFont
        addSubview(messageLabel)
    }

    fileprivate func getFrameBy(_ position: AlertPosition, direction: AnimationDirection) -> CGRect {
        let frame: CGRect

        switch position {
        case .top:
            frame = getFrameOfTopPositionBy(direction)
        case .bottom:
            frame = getFrameOfBottomPositionBy(direction)
        }

        return frame
    }

    fileprivate func getFrameOfTopPositionBy(_ direction: AnimationDirection) -> CGRect {
        let frame: CGRect
        switch direction {
        case .toRight:
            frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: height)
        case .toLeft:
            frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: height)
        case .normal:
            frame = CGRect(x: 0.0, y: -height, width: screenWidth, height: height)
        }
        return frame
    }

    fileprivate func getFrameOfBottomPositionBy(_ direction: AnimationDirection) -> CGRect {
        let frame: CGRect
        switch direction {
        case .toRight:
            frame = CGRect(x: -screenWidth, y: screenHeight - height, width: screenWidth, height: height)
        case .toLeft:
            frame = CGRect(x: screenWidth, y: screenHeight - height, width: screenWidth, height: height)
        case .normal:
            frame = CGRect(x: 0.0, y: screenHeight + height, width: screenWidth, height: height)
        }
        return frame
    }

    @objc func viewDidTap() {
        if let didTapBlock = didTapBlock {
            didTapBlock()
            hide(self)
        }
    }

    // MARK: - Hub methods

    @objc fileprivate func show(_ title: String, message: String?, topLabelColor: UIColor, messageLabelColor: UIColor, backgroundColor: UIColor?) {
        addWindowSubview(self)
        configureProperties(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor)

        UIView.animate(withDuration: duration, animations: {
            switch self.direction {
            case .toRight:
                self.frame.origin.x = 0
            case .toLeft:
                self.frame.origin.x = 0
            case .normal:
                self.frame.origin.y = self.position == .top ? 0 : self.screenHeight - self.height
            }
    })
        // perform(#selector(hide), with: self, afterDelay: self.delay)
    }

    @objc func hide(_ alertView: UIButton) {
        UIView.animate(withDuration: duration, animations: {
            switch self.direction {
            case .toRight:
                self.frame.origin.x = -self.screenWidth
            case .toLeft:
                self.frame.origin.x = self.screenWidth
            case .normal:
                (self.position == .top) ? (alertView.frame.origin.y = -self.height) : (alertView.frame.origin.y = self.screenHeight)
            }
    })

        perform(#selector(remove), with: alertView, afterDelay: delay)
    }

    @objc fileprivate func addWindowSubview(_ view: UIView) {
        if superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal,
                    !window.isHidden,
                    window.frame != CGRect.zero {
                    window.addSubview(view)
                    return
                }
            }
        }
    }

    @objc fileprivate func remove(_ alertView: UIButton) {
        alertView.removeFromSuperview()
    }

    @objc fileprivate func configureProperties(_ title: String, message: String?, topLabelColor: UIColor?, messageLabelColor: UIColor?, backgroundColor: UIColor?) {
        topLabel.text = title

        if let message = message {
            messageLabel.text = message
        } else {
            messageLabel.isHidden = true
            topLabel.frame.origin.y = height / 2

            if position == .bottom {
                topLabel.frame.origin.y = height / 2 - topLabel.frame.height / 2
            }
        }

        if let topLabelColor = topLabelColor {
            topLabel.textColor = topLabelColor
        }

        if let messageLabelColor = messageLabelColor {
            messageLabel.textColor = messageLabelColor
        }

        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }

    // MARK: Interface

    open func alertWith(_ title: String,
                        message: String? = nil,
                        topLabelColor: UIColor = UIColor.white,
                        messageLabelColor: UIColor = UIColor.white,
                        backgroundColor: UIColor = UIColor.lightRed()) {
        delay = 2.0
        show(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor)
    }

    open func alertWith(_ title: String,
                        message: String? = nil,
                        topLabelColor: UIColor = UIColor.white,
                        messageLabelColor: UIColor = UIColor.white,
                        backgroundColor: UIColor = UIColor.lightRed(),
                        delay: Double) {
        self.delay = delay
        show(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor)
    }
}

extension UIColor {
    public class func lightRed() -> UIColor {
        return UIColor(red: 255 / 255, green: 102 / 255, blue: 102 / 255, alpha: 0.9)
    }
}
