//
//  ArrayExtension.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 29.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import Foundation

extension Array {
    mutating func forEach(body: (inout Element) throws -> Void) rethrows {
        for index in self.indices {
            try body(&self[index])
        }
    }
}
