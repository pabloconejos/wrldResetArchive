//
//  ContentView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//


import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Inicio", systemImage: "house") {
                HomeView()
            }

            Tab("Buscar", systemImage: "magnifyingglass") {
                SearchView()
            }

            Tab("Perfil", systemImage: "person.crop.circle") {
                ProfileView()
            }
        }
    }
}


#Preview {
    RootView()
}
