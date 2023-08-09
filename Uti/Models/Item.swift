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
    case poll
    case party
    case wine
    case bike
    case netflix
    case water
    case tea
    case cupNoodles
    case avocado
    case chocolate
    case banana
    case sushi
    case coffe
    case pill
    case condom
    case absorbentPanties
    case collector
    case absorbent
    case contraceptive
    case warmCompress
    case medicineColic
}

extension Item{
    static func getItems(category: Category) -> [Item] {
        switch category {
        case .leisure:
            return([
                Item(name: .bike, type: .leisure, iconPath: "Party Icon", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .netflix, type: .leisure, iconPath: "Party Icon", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .wine, type: .leisure, iconPath: "wine", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .book, type: .leisure, iconPath: "book", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .spaDay, type: .leisure, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 5, .pms: 10]),
                Item(name: .poll, type: .leisure, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .party, type: .leisure, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: -5, .pms: 5]),
                Item(name: .games, type: .leisure, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5])
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
                Item(name: .coffe, type: .nutrition, iconPath: "coffee", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .tea, type: .nutrition, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 10]),
                Item(name: .cupNoodles, type: .nutrition, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5]),
                Item(name: .avocado, type: .nutrition, iconPath: "invisibleFrame", amount: 100, price: 10, effect: [.fertile : 10, .folicular: 10, .luteal: 10, .menstrual: 10, .pms: 5])
            ])
        }
    }
}
