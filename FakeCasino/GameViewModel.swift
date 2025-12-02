//
//  GameViewModel.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class GameViewModel {
    var player: Player?
    var modelContext: ModelContext?
    
    // Game State
    var betAmount: Double = 10.0
    var gameMessage: String = "Place your bet!"
    
    // Work State
    var timeRemaining: TimeInterval = 0
    var timer: Timer?
    var isWorking: Bool = false
    
    func setContext(_ context: ModelContext) {
        self.modelContext = context
        fetchPlayer()
    }
    
    private func fetchPlayer() {
        guard let context = modelContext else { return }
        let descriptor = FetchDescriptor<Player>()
        do {
            let players = try context.fetch(descriptor)
            if let existingPlayer = players.first {
                self.player = existingPlayer
            } else {
                let newPlayer = Player()
                context.insert(newPlayer)
                self.player = newPlayer
            }
            checkWorkCooldown()
        } catch {
            print("Failed to fetch player: \(error)")
        }
    }
    
    // MARK: - Leveling System
    private func addXP(_ amount: Int) {
        guard let player = player else { return }
        player.currentXP += amount
        
        // Simple level up formula: Level * 100 XP required
        let xpRequired = player.level * 100
        if player.currentXP >= xpRequired {
            player.level += 1
            player.currentXP -= xpRequired
            // Bonus for leveling up
            player.balance += Double(player.level * 50)
            addTransaction(amount: Double(player.level * 50), type: .earn, desc: "Level \(player.level) Bonus")
        }
    }
    
    // MARK: - Transactions
    private func addTransaction(amount: Double, type: TransactionType, desc: String) {
        guard let context = modelContext else { return }
        let transaction = Transaction(amount: amount, type: type, desc: desc)
        context.insert(transaction)
    }
    
    // MARK: - Work Mechanism
    func work() {
        guard let player = player else { return }
        guard timeRemaining <= 0 else { return }
        
        let earnings = Double.random(in: 10...50)
        player.balance += earnings
        player.lastWorkDate = Date()
        addXP(10)
        addTransaction(amount: earnings, type: .earn, desc: "Work Salary")
        
        // Haptic Feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        checkWorkCooldown()
    }
    
    func checkWorkCooldown() {
        guard let player = player, let lastWork = player.lastWorkDate else { return }
        let cooldown: TimeInterval = 60 // 1 minute cooldown
        let timeSinceWork = Date().timeIntervalSince(lastWork)
        
        if timeSinceWork < cooldown {
            timeRemaining = cooldown - timeSinceWork
            startTimer()
        } else {
            timeRemaining = 0
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    // MARK: - Gambling (High/Low)
    func playHighLow(guessHigh: Bool) {
        guard let player = player else { return }
        guard player.balance >= betAmount else {
            gameMessage = "Insufficient funds!"
            return
        }
        
        let playerCard = Int.random(in: 1...13)
        let houseCard = Int.random(in: 1...13)
        
        // Tie goes to house (Casino always wins eventually)
        let win = (guessHigh && playerCard > houseCard) || (!guessHigh && playerCard < houseCard)
        
        if win {
            let winnings = betAmount
            player.balance += winnings
            player.wins += 1
            addXP(20)
            addTransaction(amount: winnings, type: .win, desc: "Won High/Low")
            gameMessage = "You Won! \(cardName(playerCard)) vs \(cardName(houseCard))"
        } else {
            player.balance -= betAmount
            player.losses += 1
            addXP(5) // Consolation XP
            addTransaction(amount: betAmount, type: .loss, desc: "Lost High/Low")
            gameMessage = "You Lost! \(cardName(playerCard)) vs \(cardName(houseCard))"
        }
    }
    
    private func cardName(_ value: Int) -> String {
        switch value {
        case 1: return "Ace"
        case 11: return "Jack"
        case 12: return "Queen"
        case 13: return "King"
        default: return "\(value)"
        }
    }
    
    // MARK: - Slots
    let slotsSymbols = ["🍒", "🍋", "💎", "7️⃣"]
    var reels = ["🍒", "🍒", "🍒"]
    
    func playSlots() {
        guard let player = player else { return }
        guard player.balance >= betAmount else {
            gameMessage = "Insufficient funds!"
            return
        }
        
        // Spin logic
        reels = reels.map { _ in slotsSymbols.randomElement()! }
        
        // Determine win
        let uniqueSymbols = Set(reels)
        
        if uniqueSymbols.count == 1 {
            // Jackpot (3 match)
            let winnings = betAmount * 10
            player.balance += winnings
            player.wins += 1
            addXP(100)
            addTransaction(amount: winnings, type: .win, desc: "Slots Jackpot! \(reels.joined())")
            gameMessage = "JACKPOT! \(reels.joined())"
        } else if uniqueSymbols.count == 2 {
            // Small Win (2 match)
            let winnings = betAmount * 2
            player.balance += winnings
            player.wins += 1
            addXP(20)
            addTransaction(amount: winnings, type: .win, desc: "Slots Win! \(reels.joined())")
            gameMessage = "Nice Win! \(reels.joined())"
        } else {
            // Loss
            player.balance -= betAmount
            player.losses += 1
            addXP(5)
            addTransaction(amount: betAmount, type: .loss, desc: "Slots Loss \(reels.joined())")
            gameMessage = "Try Again! \(reels.joined())"
        }
    }
    
    // MARK: - Shop
    func buyItem(_ item: ShopItem) {
        guard let player = player else { return }
        guard !player.ownedItemIds.contains(item.id) else { return }
        
        if player.balance >= item.price {
            player.balance -= item.price
            player.ownedItemIds.append(item.id)
            addTransaction(amount: item.price, type: .spend, desc: "Bought \(item.name)")
        }
    }
}
