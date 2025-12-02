//
//  HistoryView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                HStack {
                    VStack(alignment: .leading) {
                        Text(transaction.desc)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(transaction.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text(amountString(for: transaction))
                        .fontWeight(.bold)
                        .foregroundStyle(color(for: transaction))
                }
                .listRowBackground(Color.clear)
            }
        }
        .scrollContentBackground(.hidden)
        .background(LinearGradient.mainBackground)
        .navigationTitle("History")
    }
    
    private func amountString(for transaction: Transaction) -> String {
        let prefix = (transaction.type == .earn || transaction.type == .win) ? "+" : "-"
        return prefix + String(format: "$%.2f", transaction.amount)
    }
    
    private func color(for transaction: Transaction) -> Color {
        return (transaction.type == .earn || transaction.type == .win) ? .casinoGreen : .casinoRed
    }
}
