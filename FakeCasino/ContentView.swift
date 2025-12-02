//
//  ContentView.swift
//  FakeCasino
//
//  Created by Wiktor Bramer on 02/12/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = GameViewModel()
    
    var body: some View {
        TabView {
            DashboardView(viewModel: viewModel)
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            WorkView(viewModel: viewModel)
                .tabItem {
                    Label("Work", systemImage: "briefcase.fill")
                }
            
            GameView(viewModel: viewModel)
                .tabItem {
                    Label("Game", systemImage: "suit.spade.fill")
                }
            
            ShopView(viewModel: viewModel)
                .tabItem {
                    Label("Shop", systemImage: "cart.fill")
                }
            
            NavigationView {
                HistoryView()
            }
            .tabItem {
                Label("History", systemImage: "clock.fill")
            }
        }
        .onAppear {
            viewModel.setContext(modelContext)
        }
        .preferredColorScheme(.dark) // Force Dark Mode for the aesthetic
        .tint(Color.casinoGold)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Player.self, Transaction.self], inMemory: true)
}
