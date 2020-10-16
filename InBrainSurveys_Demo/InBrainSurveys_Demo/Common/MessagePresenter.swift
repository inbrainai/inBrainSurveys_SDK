//
//  MessagePresenterViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Sergey Blazhko on 07.10.2020.
//  Copyright © 2020 InBrain. All rights reserved.
//

import UIKit

enum AlertType {
    case error, loading
    var color: UIColor {
        switch self {
            case .error: return UIColor(red: 1, green: 0.36, blue: 0.36, alpha: 1)
            case .loading: return UIColor(red: 0.000, green: 0.486, blue: 0.988, alpha: 1.000)
        }
    }
}

class MessagePresenter {
    typealias EmptyCallback = (() -> Void)
    static let shared: MessagePresenter = MessagePresenter()
    
    private weak var alert: JDropDownAlert?
    
    func show(message: String, type: AlertType) {
        DispatchQueue.main.async {
            if let alert = self.alert { alert.hide(alert) }
            
            let alert = JDropDownAlert()
            alert.alertWith(message, message: nil,
                            topLabelColor: .white, messageLabelColor: .white,
                            backgroundColor: type.color)
            
            self.alert = alert
            
            if case .loading = type { return }
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in self?.hideAlert() }
        }
    }
    
    func show(error: Error) {
        show(message: error.localizedDescription, type: .error)
    }
    
    func hideAlert() {
        DispatchQueue.main.async {
            guard let alert = self.alert else { return }
            alert.hide(alert)
        }
    }
}
