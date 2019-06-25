//
//  InBrainToken.swift
//  Zap
//
//  Created by Joel Myers on 6/18/19.
//  Copyright © 2019 Sascha Wise. All rights reserved.
//

import Foundation

public struct InBrainToken : Codable{
    public let access_token: String
//    public let refresh_token: String?
    public let expires_in: Int
    public let token_type: String
}
