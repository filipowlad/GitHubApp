//
//  ProfileTextFieldsPlaysholders.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import Foundation

enum ProfileTextFieldsPlaysholders: String {
    case name, blog, company, location
    
    var playsholder: String {
        switch self {
        case .name:
            return "Name or nickname"
        case .blog:
            return "example.com"
        case .company:
            return "Company name"
        case .location:
            return "City"
        }
    }
}
