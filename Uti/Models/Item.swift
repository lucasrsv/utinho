//
//  Item.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation

struct Item {
    var name: String
    var type: Category
    var iconPath: String
    var amount: Int
    var price: Int
    var effect: [Phase: Int]
}

enum Category {
    case leisure
    case health
    case nutrition
}
