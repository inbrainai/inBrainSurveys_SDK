//
//  InBrainReward.swift
//  InBrainSurveys
//
//  Created by Joel Myers on 4/2/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation

protocol InBrainRewardDelegate {
    func inBrainDidReceiveReward(withReward: InBrainReward)
}

public class InBrainReward : NSObject, Codable {
    var transactionIdentifier : String?
    var rewardAmount : Int?
    var currencyName : Int?
    var payoutEvent : Int?
    var placementID : String?
}
