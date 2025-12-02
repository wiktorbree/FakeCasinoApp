//
//  Transaction.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import Foundation
import SwiftData

enum TransactionType: String, Codable {
    case earn
    case spend
    case win
    case loss
}

@Model
final class Transaction {
    var amount: Double
    var type: TransactionType
    var date: Date
    var desc: String
    
    init(amount: Double, type: TransactionType, date: Date = Date(), desc: String) {
        self.amount = amount
        self.type = type
        self.date = date
        self.desc = desc
    }
}
