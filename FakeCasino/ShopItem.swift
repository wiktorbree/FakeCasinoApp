//
//  ShopItem.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import Foundation

struct ShopItem: Identifiable, Codable {
    let id: String
    let name: String
    let icon: String
    let price: Double
    
    static let allItems: [ShopItem] = [
        ShopItem(id: "bronze_card", name: "Bronze Member", icon: "creditcard", price: 500),
        ShopItem(id: "silver_card", name: "Silver Member", icon: "creditcard.fill", price: 2000),
        ShopItem(id: "gold_card", name: "Gold Member", icon: "crown.fill", price: 10000),
        ShopItem(id: "diamond_hands", name: "Diamond Hands", icon: "hand.raised.fingers.spread.fill", price: 50000),
        ShopItem(id: "private_jet", name: "Private Jet", icon: "airplane", price: 1000000)
    ]
}
