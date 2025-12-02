//
//  WorkView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI

struct WorkView: View {
    @Bindable var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Work Shift")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Spacer()
            
            if viewModel.timeRemaining > 0 {
                VStack(spacing: 20) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.secondary)
                    Text("Cooldown")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(timeString(time: viewModel.timeRemaining))
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .foregroundStyle(.white)
                }
                .padding(40)
                .glassCard()
            } else {
                Button(action: {
                    viewModel.work()
                }) {
                    VStack(spacing: 15) {
                        Image(systemName: "briefcase.fill")
                            .font(.system(size: 50))
                        Text("Start Shift")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(40)
                    .background(LinearGradient.goldGradient)
                    .cornerRadius(20)
                    .shadow(color: Color.orange.opacity(0.5), radius: 15, x: 0, y: 5)
                }
            }
            
            Spacer()
            
            Text("Earn $10 - $50 per shift")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(LinearGradient.mainBackground)
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
