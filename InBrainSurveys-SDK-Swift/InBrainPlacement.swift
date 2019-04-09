//
//  InBrainPlacement.swift
//  InBrainSurveys
//
//  Created by Joel Myers on 4/2/19.
//  Copyright © 2019 InBrain. All rights reserved.
//

import Foundation

class InBrainPlacement : NSObject {
    var placementID : String?
    var currencyName : String?
    var placementErrorMsg : String?
    var isInBrainWebViewAvailable : Bool?
    var hasHotSurvey : Bool?
    var placementCode : Int?
    var maxPayoutInCurrency : Int?
    var minPayoutInCurrency : Int?
    var maxSurveyLength : Int?
    var minSurveyLength : Int?
}
