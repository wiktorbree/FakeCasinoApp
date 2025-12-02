//
//  Player.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class Player {
    var balance: Double
    var level: Int
    var currentXP: Int
    var wins: Int
    var losses: Int
    var lastWorkDate: Date?
    var ownedItemIds: [String]
    
    init(balance: Double = 100.0, level: Int = 1, currentXP: Int = 0, wins: Int = 0, losses: Int = 0, lastWorkDate: Date? = nil, ownedItemIds: [String] = []) {
        self.balance = balance
        self.level = level
        self.currentXP = currentXP
        self.wins = wins
        self.losses = losses
        self.lastWorkDate = lastWorkDate
        self.ownedItemIds = ownedItemIds
    }
}
