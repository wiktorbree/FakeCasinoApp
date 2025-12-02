//
//  GameView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI

struct GameView: View {
    @Bindable var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Game Hub")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                NavigationLink(destination: HighLowView(viewModel: viewModel)) {
                    GameCard(title: "High / Low", icon: "arrow.up.arrow.down", color: .casinoPurple)
                }
                
                NavigationLink(destination: SlotsView(viewModel: viewModel)) {
                    GameCard(title: "Slots", icon: "square.grid.3x3.fill", color: .casinoGold)
                }
                
                Spacer()
            }
            .padding()
            .background(LinearGradient.mainBackground)
        }
    }
}

struct GameCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(.white)
                .frame(width: 60)
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(30)
        .background(color.opacity(0.8))
        .cornerRadius(20)
        .shadow(color: color.opacity(0.4), radius: 10, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}
