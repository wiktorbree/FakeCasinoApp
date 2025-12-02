//
//  SlotsView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI

struct SlotsView: View {
    @Bindable var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Slots")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Spacer()
            
            // Reels
            HStack(spacing: 10) {
                ForEach(0..<3) { index in
                    Text(viewModel.reels[index])
                        .font(.system(size: 80))
                        .frame(width: 100, height: 150)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(LinearGradient.goldGradient, lineWidth: 2)
                        )
                }
            }
            .padding()
            
            // Game Controls
            VStack(spacing: 20) {
                Text(viewModel.gameMessage)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .glassCard()
                
                HStack {
                    Text("Bet Amount:")
                        .foregroundStyle(.secondary)
                    TextField("Amount", value: $viewModel.betAmount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                }
                .padding()
                .glassCard()
                
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                        viewModel.playSlots()
                    }
                }) {
                    Text("SPIN")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient.goldGradient)
                        .foregroundStyle(.white)
                        .cornerRadius(20)
                        .shadow(color: Color.orange.opacity(0.5), radius: 10, x: 0, y: 5)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .background(LinearGradient.mainBackground)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
