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
    var name: String?
    
    var credentials: [(key: String, value: String?)] = [("email", nil),
                                         ("blog", nil),
                                         ("company", nil),
                                         ("location", nil)]
    
    var editableData: [(key: String, value: String?)] = [("name", nil),
                                                         ("blog", nil),
                                                         ("company", nil),
                                                         ("location", nil)]
    
    enum CodingKeys : String, CodingKey {
        case avatarURL = "avatar_url", bio, login, name, email, location, blog, company
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        bio = try container.decode(String?.self, forKey: .bio)
        login = try container.decode(String.self, forKey: .login)
        name = try container.decode(String.self, forKey: .name)
        for index in credentials.indices {
            credentials[index].value = try! container.decode(String?.self, forKey: CodingKeys(rawValue: credentials[index].key)!)
        }
        for index in editableData.indices{
            if index == 0 { editableData[index].value = name }
            else { editableData[index].value = credentials[index].value }
        }
    }
}
