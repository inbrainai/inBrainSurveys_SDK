//
//  OptionsViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 4/15/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import UIKit
import InBrainSurveys

class OptionsViewController: UIViewController, LoadableView {
    @IBOutlet weak var pointsLabel: UILabel?
    
    private let inBrain: InBrain = InBrain.shared
    private var totalPoints: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInBrain()
        updatePoints()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - IBActions     
    @IBAction func showInBrain(_ sender: UIButton) {
        startActivity()
        view.isUserInteractionEnabled = false
        MessagePresenter.shared.show(message: "Loading Surveys", type: .loading)

        inBrain.checkForAvailableSurveys { [weak self] hasSurveys, _  in
            MessagePresenter.shared.hideAlert()
            self?.view.isUserInteractionEnabled = true
            self?.stopActivity()

            guard hasSurveys else {
                MessagePresenter.shared.show(message: "Ooops.. No surveys available right now!", type: .error)
                return
            }

            self?.inBrain.showSurveys()
        }
    }

    @IBAction func showNativeSurveys(_ sender: UIButton) {
        performSegue(withIdentifier: "toNativeSurveys", sender: nil)
    }
}

//MARK: - InBrainDelegate
//All the methods are optional
extension OptionsViewController: InBrainDelegate {
    func didFailToReceiveRewards(error: Error) {
        MessagePresenter.shared.show(message: "Ooops.. Something went wrong", type: .error)
    }
    
    //Required if isS2S: false
    func didReceiveInBrainRewards(rewardsArray: [InBrainReward]) {
        if rewardsArray.isEmpty { return }
        
        for reward in rewardsArray {
            totalPoints += reward.amount
        }
        updatePoints()
        
        //Process rewards inside your app as you needed
        //And confirm them just you finished
        let ids = rewardsArray.map { $0.transactionId }
        inBrain.confirmRewards(txIdArray: ids)
    }
    
    func surveysClosed(byWebView: Bool, completedSurvey: Bool, rewards: [InBrainSurveyReward]?) {
        print("Surveys closed")
    }
}

//MARK: - Private

private extension OptionsViewController {
     func setupInBrain() {
        //--- Required config ---
        inBrain.setInBrain(apiClientID: "The client ID provided in inBrain.ai dashboard",
                           apiSecret: "The client secret provided in inBrain.ai dashboard",
                           isS2S: false)
        
        //Required if isS2S: false
        inBrain.inBrainDelegate = self

        //--- Optional config ---
        
        //If no userId set - `identifierForVendor` will be used.
        inBrain.set(userID: "Uniq identifier of the user within your application")

        // Value to track each user session. This value is provided via S2S Callbacks as SessionId.
        inBrain.setSessionID("testing33_Session")
        
        //Customize Navigation Bar
        //Example to match InBrain V2 theme (Native Surveys)
        //Please, note: color values should be in sRGB (Device RGB) profile
        
        //Default parameters are used for this example. If you would like to use default appearance - you can skip this step.

        let config = InBrainNavBarConfig(backgroundColor: UIColor(hex: "00a5ed"), buttonsColor: .white,
                                         titleColor: .white, isTranslucent: false, hasShadow: false)
        inBrain.setNavigationBarConfig(config)
        
        //Customize Status Bar
        //Please, note: In order to customize status bar - needs to set View controller-based status bar appearance to YES.
        
        //Default parameters are used for this example. If you would like to use default appearance - you can skip this step.
        let statusBarConfig = InBrainStatusBarConfig(statusBarStyle: .lightContent, hideStatusBar: false)
        inBrain.setStatusBarConfig(statusBarConfig)
    }
    
    func updatePoints() {
        pointsLabel?.text = String(format: "Total Points: %.0f", totalPoints)
    }

}
