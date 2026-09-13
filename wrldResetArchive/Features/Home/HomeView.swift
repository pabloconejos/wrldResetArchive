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
                } else if let errorMessage = viewModel.initialLoadErrorMessage {
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
            .alert(
                "No se pudo actualizar",
                isPresented: isPresentingRefreshError
            ) {
                Button("Aceptar", role: .cancel) {
                    viewModel.dismissRefreshError()
                }
            } message: {
                Text(viewModel.refreshErrorMessage ?? "")
            }
        }
    }

    private var isPresentingRefreshError: Binding<Bool> {
        Binding(
            get: { viewModel.refreshErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.dismissRefreshError()
                }
            }
        )
    }
}
