//
//  TypeError.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 30.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import Foundation

import Foundation

enum TypeError: Error {
    case dataIsAbsent
    case userInvalid
    case imageInvalid
    
    var localizedDescription: String {
        switch self {
        case .dataIsAbsent:
            return "Data does not exists"
        case .userInvalid:
            return "User is invalid"
        case .imageInvalid:
            return "Image is invalid"
        }
    }
}
