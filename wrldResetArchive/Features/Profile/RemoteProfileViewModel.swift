//
//  RemoteProfileViewModel.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 30/08/2026.
//

import Combine
import Foundation

@MainActor
final class RemoteProfileViewModel: ObservableObject {

    @Published private(set) var profile: APIInstagramProfile?
    @Published private(set) var summary: APIInstagramProfileSummary?
    @Published private(set) var contents: [APIInstagramContent] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let apiClient: WrldresetAPIClient

    init(apiClient: WrldresetAPIClient? = nil) {
        self.apiClient = apiClient ?? WrldresetAPIClient()
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            let profiles = try await apiClient.fetchProfiles()

            guard let firstProfile = profiles.first else {
                errorMessage = "No profiles found"
                isLoading = false
                return
            }

            profile = firstProfile

            async let summaryRequest = apiClient.fetchProfileSummary(profileId: firstProfile.id)
            async let contentsRequest = apiClient.fetchContents(
                profileId: firstProfile.id,
                page: 0,
                size: 30
            )

            summary = try await summaryRequest
            contents = try await contentsRequest.content

            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }

    func mediaURL(for mediaItem: APIMediaItem) -> URL {
        apiClient.mediaURL(for: mediaItem)
    }
}
