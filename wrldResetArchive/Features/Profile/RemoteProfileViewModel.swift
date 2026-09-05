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
    @Published private(set) var isLoadingMore = false

    private var currentContentsPage = 0
    private var totalContentsPages = 1
    private let contentsPageSize = 30

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
                size: contentsPageSize
            )

            summary = try await summaryRequest

            let firstContentsPage = try await contentsRequest
            contents = firstContentsPage.content
            currentContentsPage = firstContentsPage.page.number
            totalContentsPages = firstContentsPage.page.totalPages

            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }

    func mediaURL(for mediaItem: APIMediaItem) -> URL {
        apiClient.mediaURL(for: mediaItem)
    }
    
    func loadMoreContentsIfNeeded(currentContent: APIInstagramContent) async {
        guard shouldLoadMore(currentContent: currentContent) else {
            return
        }

        await loadMoreContents()
    }

    private func shouldLoadMore(currentContent: APIInstagramContent) -> Bool {
        guard !isLoading else {
            return false
        }

        guard !isLoadingMore else {
            return false
        }

        guard currentContentsPage + 1 < totalContentsPages else {
            return false
        }

        guard let currentIndex = contents.firstIndex(where: { $0.id == currentContent.id }) else {
            return false
        }

        let thresholdIndex = contents.index(
            contents.endIndex,
            offsetBy: -6
        )

        return currentIndex >= thresholdIndex
    }

    private func loadMoreContents() async {
        guard let profile else {
            return
        }

        isLoadingMore = true
        errorMessage = nil

        do {
            let nextPage = currentContentsPage + 1

            let nextContentsPage = try await apiClient.fetchContents(
                profileId: profile.id,
                page: nextPage,
                size: contentsPageSize
            )

            contents.append(contentsOf: nextContentsPage.content)
            currentContentsPage = nextContentsPage.page.number
            totalContentsPages = nextContentsPage.page.totalPages
            isLoadingMore = false
        } catch {
            errorMessage = error.localizedDescription
            isLoadingMore = false
        }
    }
}
