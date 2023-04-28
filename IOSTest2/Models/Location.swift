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

struct Location: Codable, Hashable {
    var locationName: String
    var description: String?
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case locationName
        case description
        case date
    }
}
