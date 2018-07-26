//
//  UserInfo.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
    
    let avatarURL: String?
    let bio: String?
    let login: String?
    let name: String?
    var credentials: [String:String?] = ["email": nil,
                                         "url": nil,
                                         "company": nil,
                                         "location": nil]
    
    enum CodingKeys : String, CodingKey {
        case avatarURL = "avatar_url", bio, login, name, email, location, url, company
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        bio = try container.decode(String?.self, forKey: .bio)
        login = try container.decode(String.self, forKey: .login)
        name = try container.decode(String.self, forKey: .name)
        for key in credentials.keys {
            credentials[key] = try container.decode(String?.self, forKey: CodingKeys(rawValue: key)!)
        }
    }
}
