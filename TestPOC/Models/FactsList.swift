//
//  FactsList.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/23/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

struct Facts {
    var title: String?
    var rows: [Rows]
    
    init(title: String?, rows: [Rows]) {
        self.title = title
        self.rows = rows
    }
    
   static func addFacts(jsonObject: [String: AnyObject]) -> [Facts] {
        var facts = [Facts]()
        if let rowsObject = jsonObject["rows"] as? [[String: AnyObject]] {
            var rowsArray = [Rows]()
            for object in rowsObject {
                let title = object["title"] as? String
                let desc = object["description"] as? String
                let imageUrl = object["imageHref"] as? String
                rowsArray.append(Rows(title: title, description: desc, imageUrl: imageUrl))
            }
            let factList = Facts(title: jsonObject["title"] as? String, rows: rowsArray)
            facts.append(factList)
        }
        return facts
    }
}

struct Rows {
    var title: String?
    var description: String?
    var imageUrl: String?
}
