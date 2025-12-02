//
//  DesignSystem.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI

extension Color {
    static let casinoDark = Color(red: 0.1, green: 0.1, blue: 0.15)
    static let casinoPurple = Color(red: 0.5, green: 0.2, blue: 0.8)
    static let casinoGold = Color(red: 1.0, green: 0.8, blue: 0.2)
    static let casinoGreen = Color(red: 0.2, green: 0.8, blue: 0.4)
    static let casinoRed = Color(red: 0.9, green: 0.3, blue: 0.3)
}

extension LinearGradient {
    static let mainBackground = LinearGradient(
        colors: [Color.casinoDark, Color.black],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cardGradient = LinearGradient(
        colors: [Color.white.opacity(0.1), Color.white.opacity(0.05)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let goldGradient = LinearGradient(
        colors: [Color.casinoGold, Color.orange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(LinearGradient.cardGradient)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard() -> some View {
        self.modifier(GlassCard())
    }
}
