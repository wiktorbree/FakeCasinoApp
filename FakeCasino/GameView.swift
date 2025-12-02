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
        VStack(spacing: 20) {
            Text("High / Low")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Spacer()
            
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
                
                HStack(spacing: 20) {
                    Button(action: { viewModel.playHighLow(guessHigh: false) }) {
                        VStack {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.largeTitle)
                            Text("LOW")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.casinoRed)
                        .cornerRadius(15)
                    }
                    
                    Button(action: { viewModel.playHighLow(guessHigh: true) }) {
                        VStack {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.largeTitle)
                            Text("HIGH")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.casinoGreen)
                        .cornerRadius(15)
                    }
                }
                .foregroundStyle(.white)
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
