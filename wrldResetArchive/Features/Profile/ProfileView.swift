import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: RemoteProfileViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let profile = viewModel.profile {
                    ScrollView {
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
                    }
                    .ignoresSafeArea(.container, edges: .bottom)
                    .refreshable {
                        await viewModel.refresh()
                    }
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
            } // este .task significa => Cuando esta vista aparece en pantalla, ejecuta esta tarea asíncrona.
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
