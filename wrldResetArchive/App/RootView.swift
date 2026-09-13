//
//  ContentView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//


import SwiftUI

struct RootView: View {

    @StateObject private var profileViewModel = RemoteProfileViewModel()

    var body: some View {
        TabView {
            Tab("Inicio", systemImage: "house") {
                HomeView(viewModel: profileViewModel)
            }

            Tab("Buscar", systemImage: "magnifyingglass") {
                SearchView()
            }

            Tab("Perfil", systemImage: "person.crop.circle") {
                ProfileView(viewModel: profileViewModel)
            }
        }
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .tabBarMinimizeBehavior(.never)
    }
}


#Preview {
    RootView()
}
