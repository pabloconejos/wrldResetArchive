//
//  ProfileView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileView: View {
    
    let profile: InstagramProfile
    let repository: InstagramRepository
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ProfileInfoView(profile: profile)

                    ProfileDescriptionView(profile: profile)

                    ProfileActionButtonsView()

                    ProfileTabSelectorView(
                        posts: repository.posts.filter { post in
                            post.profileID == profile.id
                        },
                        repository: repository
                    )

                }
            }
            .navigationTitle("wrldreset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    addButton
                    optionsMenu
                }
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
