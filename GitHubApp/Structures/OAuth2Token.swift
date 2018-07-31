//
//  OAuth2Token.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import Foundation

struct OAuth2Token: Decodable {
    
    let tokenType: String
    let accessToken: String
    
    enum CodingKeys : String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tokenType = try container.decode(String.self, forKey: .tokenType)
        accessToken = try container.decode(String.self, forKey: .accessToken)
    }
}
