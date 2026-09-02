import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = RemoteProfileViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "No se pudo cargar",
                        systemImage: "wifi.exclamationmark",
                        description: Text(errorMessage)
                    )
                } else if let profile = viewModel.profile {
                    VStack(spacing: 0) {
                        VStack(spacing: 16) {
                            ProfileInfoView(
                                profile: profile,
                                summary: viewModel.summary
                            )

                            ProfileDescriptionView(profile: profile)

                            ProfileActionButtonsView()
                        }

                        ProfileTabSelectorView(
                            contents: viewModel.contents,
                            viewModel: viewModel
                        )
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle(viewModel.profile?.username ?? "Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    addButton
                    optionsMenu
                }
            }
            .task {
                await viewModel.load()
            }
        }
    }

    private var addButton: some View {
        Button {
            print("Añadir publicación")
        } label: {
            Image(systemName: "plus")
        }
    }

    private var optionsMenu: some View {
        Menu {
            Button {
                print("Abrir configuración")
            } label: {
                Label("Configuración", systemImage: "gear")
            }

            Button {
                print("Abrir archivo")
            } label: {
                Label("Información del archivo", systemImage: "archivebox")
            }

            Button {
                print("About App")
            } label: {
                Label("About App", systemImage: "info.circle")
            }
        } label: {
            Image(systemName: "line.3.horizontal")
        }
    }
}
