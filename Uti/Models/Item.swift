//
//  Item.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation

struct Item: Codable {
    var name: ItemName
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

enum ItemName: Codable {
    case spaDay
    case book
    case games
    case netflix
    case chocolate
    case coffe
    case cupNoodles
    case banana
    case avocado
    case xuxi
    case contraceptive
    case pill
    case condom
    case medicineColic
    case warmCompress
    case absorbent
    case collector
    case absorbentPanties
}
