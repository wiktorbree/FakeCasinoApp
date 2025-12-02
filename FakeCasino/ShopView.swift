//
//  ShopView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI

struct ShopView: View {
    @Bindable var viewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("VIP Shop")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ForEach(ShopItem.allItems) { item in
                    ShopItemRow(item: item, viewModel: viewModel)
                }
            }
            .padding()
        }
        .background(LinearGradient.mainBackground)
    }
}

struct ShopItemRow: View {
    let item: ShopItem
    var viewModel: GameViewModel
    
    var isOwned: Bool {
        viewModel.player?.ownedItemIds.contains(item.id) ?? false
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.icon)
                .font(.title)
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.1))
                .clipShape(Circle())
                .foregroundStyle(isOwned ? Color.casinoGold : .white)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text("$\(item.price, specifier: "%.0f")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if isOwned {
                Text("OWNED")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.casinoGreen)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            } else {
                Button(action: {
                    viewModel.buyItem(item)
                }) {
                    Text("BUY")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(viewModel.player?.balance ?? 0 >= item.price ? Color.casinoPurple : Color.gray)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.player?.balance ?? 0 < item.price)
            }
        }
        .padding()
        .glassCard()
    }
}
