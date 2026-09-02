//
//  APIDebugView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 30/08/2026.
//

import SwiftUI

struct APIDebugView: View {

    @State private var text = "Sin cargar"
    @State private var imageURL: URL?
    private let apiClient = WrldresetAPIClient()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("API Debug")
                .font(.title)

            Text(text)
                .font(.body)
                .textSelection(.enabled)
            
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxHeight: 300)
            }

            Button("Cargar perfil") {
                Task {
                    await loadProfile()
                }
            }

            Button("Cargar contenidos") {
                Task {
                    await loadContents()
                }
            }
        }
        .padding()
    }

    private func loadProfile() async {
        do {
            let profiles = try await apiClient.fetchProfiles()

            if let profile = profiles.first {
                text = """
                id: \(profile.id)
                username: \(profile.username)
                displayName: \(profile.displayName ?? "-")
                website: \(profile.website ?? "-")
                """
            } else {
                text = "No hay perfiles"
            }
        } catch {
            text = "Error: \(error.localizedDescription)"
        }
    }
    
    private func loadContents() async {
        do {
            let profiles = try await apiClient.fetchProfiles()

            guard let profile = profiles.first else {
                text = "No hay perfiles"
                return
            }

            let page = try await apiClient.fetchContents(
                profileId: profile.id,
                page: 0,
                size: 5
            )
            
            if let firstMediaItem = page.content.first?.mediaItems.first {
                imageURL = apiClient.mediaURL(for: firstMediaItem)
            }

            text = page.content
                .map { content in
                    let firstMediaUrl = content.mediaItems.first?.mediaUrl ?? "-"

                    return """
                    type: \(content.contentType.rawValue)
                    date: \(content.createdAtInstagram?.description ?? "-")
                    mediaItems: \(content.mediaItems.count)
                    firstMediaUrl: \(firstMediaUrl)
                    """
                }
                .joined(separator: "\n\n")
        } catch {
            text = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    APIDebugView()
}
