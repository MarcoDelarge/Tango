//
//  FullResponse.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation

struct FullResponse: Codable {
    var resultCount: Int?
    var results: [Album]
}
