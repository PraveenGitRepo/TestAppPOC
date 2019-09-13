//
//  FactsList.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/23/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

struct Facts: Codable {
    let title: String?
    let rows: [Rows]
    
}

struct Rows: Codable {
    let title, description: String?
    let imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "description"
        case imageHref
    }
}
