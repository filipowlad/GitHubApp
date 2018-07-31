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
    let blog: String?
    let email: String?
    let company: String?
    let location: String?
    
    var credentials: [(key: String, value: String?)] {
        return [
            (Keys.email.rawValue, email),
            (Keys.blog.rawValue, blog),
            (Keys.company.rawValue, company),
            (Keys.location.rawValue, location)
        ]
    }
    
    var editable: [(key: String, value: String?)] {
        return [
            (Keys.name.rawValue, name),
            (Keys.blog.rawValue, blog),
            (Keys.company.rawValue, company),
            (Keys.location.rawValue, location)
        ]
    }
    
    enum Keys: String, CodingKey {
        case avatarURL = "avatar_url", bio, login, name, email, location, blog, company
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        bio = try container.decode(String?.self, forKey: .bio)
        login = try container.decode(String.self, forKey: .login)
        name = try container.decode(String.self, forKey: .name)
        blog = try container.decode(String?.self, forKey: .blog)
        email = try container.decode(String?.self, forKey: .email)
        company = try container.decode(String?.self, forKey: .company)
        location = try container.decode(String?.self, forKey: .location)
    }
}
