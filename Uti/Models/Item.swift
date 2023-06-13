//
//  Item.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation

struct Item: Codable {
    var name: String
    var type: Category
    var iconPath: String
    var amount: Int
    var price: Int
    var effect: [Phase: Int]
}

enum Category: Codable {
    case leisure
    case health
    case nutrition
}
