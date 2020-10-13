//
//  OptionsViewController.swift
//  InBrainSurveys_Demo
//
//  Created by Joel Myers on 4/15/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import UIKit
import InBrainSurveys_SDK_Swift

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
            self?.stopActivity()
            self?.view.isUserInteractionEnabled = true
            
            guard hasSurveys else {
                MessagePresenter.shared.show(message: "Ooops.. No surveys available right now!", type: .error)
                return
            }
            MessagePresenter.shared.hideAlert()
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
        MessagePresenter.shared.show(message: "Ooops.. Something went wrog", type: .error)
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
    
    func surveysClosed() {
        print("Surveys closed")
    }
    
    func surveysClosedFromPage() {
        print("Surveys closed From Page")
    }

}

//MARK: - Private

private extension OptionsViewController {
     func setupInBrain() {
        //--- Required config ---
        inBrain.setInBrain(apiClientID: "Your client ID",
                           apiSecret: "Your client secret",
                           isS2S: false)
        
        //Required if isS2S: false
        inBrain.inBrainDelegate = self

        //--- Optional config ---
        
        //If no userId set - `identifierForVendor` will be used.
        inBrain.set(userID: "demo@demo.demo")
        
        //If no language set - device language will be used.
        //Supported languages may be found at SDK docs
        inBrain.setLanguage(value: "en-us")

        //Additional data to show the most suitable surveys
        let data: [[String : Any]] = [["gender": "male"], ["age" : 34]]
        inBrain.setInBrainValuesFor(sessionID: "testing33_Session", dataOptions: data)
                
        //Customize Navigation Bar
        inBrain.setNavigationBarButtonColor(.systemRed)
    }
    
    func updatePoints() {
        pointsLabel?.text = String(format: "Total Points: %.0f", totalPoints)
    }

}
