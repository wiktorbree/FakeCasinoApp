//
//  DashboardView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI

struct DashboardView: View {
    @Bindable var viewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back,")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text("High Roller")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    Image(systemName: "crown.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(LinearGradient.goldGradient)
                }
                .padding()
                
                // Balance Card
                VStack(spacing: 10) {
                    Text("Total Balance")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text("$\(viewModel.player?.balance ?? 0, specifier: "%.2f")")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundStyle(LinearGradient.goldGradient)
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .glassCard()
                
                // Level Progress
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Level \(viewModel.player?.level ?? 1)")
                            .font(.headline)
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(viewModel.player?.currentXP ?? 0) / \(viewModel.player?.level ?? 1 * 100) XP")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.white.opacity(0.1))
                                .frame(height: 10)
                            
                            let maxXP = Double((viewModel.player?.level ?? 1) * 100)
                            let currentXP = Double(viewModel.player?.currentXP ?? 0)
                            let progress = min(currentXP / maxXP, 1.0)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(LinearGradient.goldGradient)
                                .frame(width: geometry.size.width * progress, height: 10)
                        }
                    }
                    .frame(height: 10)
                }
                .padding()
                .glassCard()
                
                // Stats Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    StatCard(title: "Wins", value: "\(viewModel.player?.wins ?? 0)", icon: "trophy.fill", color: .casinoGreen)
                    StatCard(title: "Losses", value: "\(viewModel.player?.losses ?? 0)", icon: "xmark.circle.fill", color: .casinoRed)
                }
            }
            .padding()
        }
        .background(LinearGradient.mainBackground)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(color)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .glassCard()
    }
}
