//
//  Item.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import Foundation
import SwiftUI

struct Item: Codable {
    var name: ItemName
    var type: Category
    var iconPath: String
    var amount: Int
    var price: Int
    var effect: [Phase: Int] 
}

extension Item: Identifiable {
    var id: ItemName { return name }
}

enum Category: Codable {
    case leisure
    case health
    case nutrition
}

enum ItemName: Codable {
    case games
    case book
    case spaDay
    case gym
    case party
    case dateNight
    case bike
    case movieNight
    case water
    case tea
    case cupNoodles
    case redMeat
    case chocolate
    case banana
    case sushi
    case soda
    case condom
    case medicineColic
    case collector
    case absorbent
    case pill
    case absorbentPanties
    case contraceptive
    case warmCompress
    
}

extension Item{
    static func getItems(category: Category) -> [Item] {
        switch category {
        case .leisure:
            return([
                Item(name: .dateNight, type: .leisure, iconPath: "wine", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .book, type: .leisure, iconPath: "book", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .party, type: .leisure, iconPath: "game", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .games, type: .leisure, iconPath: "gym", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .spaDay, type: .leisure, iconPath: "party", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 5, .pms: 10]),
                Item(name: .gym, type: .leisure, iconPath: "spaDay", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .party, type: .leisure, iconPath: "movie", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .games, type: .leisure, iconPath: "bike", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5])
            ])
        case .health:
            return([
                Item(name: .medicineColic, type: .health, iconPath: "medicineColic", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .condom, type: .health, iconPath: "condom", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .absorbentPanties, type: .health, iconPath: "absorbent", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .collector, type: .health, iconPath: "collector", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .absorbent, type: .health, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .contraceptive, type: .health, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .warmCompress, type: .health, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10]),
                Item(name: .pill, type: .health, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular : 10, .luteal : 10, .menstrual : 10, .pms : 10])
                
            ])
        case .nutrition:
            return([
                Item(name: .water, type: .nutrition, iconPath: "water", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 10]),
                Item(name: .chocolate, type: .nutrition, iconPath: "chocolate", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .banana, type: .nutrition, iconPath: "banana", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .sushi, type: .nutrition, iconPath: "sushi", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .soda, type: .nutrition, iconPath: "soda", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .tea, type: .nutrition, iconPath: "tea", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 10]),
                Item(name: .cupNoodles, type: .nutrition, iconPath: "cupNoodles", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .redMeat, type: .nutrition, iconPath: "redMeat", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5])
            ])
        }
    }
}
