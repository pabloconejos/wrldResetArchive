//
//  HomeView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: RemoteProfileViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let profile = viewModel.profile {
                    PostFeedView(
                        profile: profile,
                        viewModel: viewModel
                    )
                } else if let errorMessage = viewModel.errorMessage {
                    ScrollView {
                        ContentUnavailableView(
                            "No se pudo cargar",
                            systemImage: "wifi.exclamationmark",
                            description: Text(errorMessage)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.top, 180)
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Inicio")
            .task {
                await viewModel.load()
            }
        }
    }
}
