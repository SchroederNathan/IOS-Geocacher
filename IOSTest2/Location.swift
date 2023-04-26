//
//  Location.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-26.
//

import UIKit
import Foundation

enum Section {
    case main
}

struct Location: Hashable {
    var locationName: String
    var description: String
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case locationName
        case description
        case date
    }
}
