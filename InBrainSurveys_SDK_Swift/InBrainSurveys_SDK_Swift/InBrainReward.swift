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

public struct InBrainReward : Codable {
    public let transactionId : Int?
    public let amount : Float?
    public let currency : String?
    public let transactionType : Int?
}
