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
    @Published private(set) var initialLoadErrorMessage: String?
    @Published private(set) var refreshErrorMessage: String?
    @Published private(set) var loadMoreErrorMessage: String?
    @Published private(set) var isLoadingMore = false

    private var currentContentsPage = 0
    private var totalContentsPages = 1
    private let contentsPageSize = 30

    private let apiClient: WrldresetAPIClient

    init(apiClient: WrldresetAPIClient? = nil) {
        self.apiClient = apiClient ?? WrldresetAPIClient()
    }

    func load() async {
        guard profile == nil else {
            return
        }

        await loadProfile(showFullScreenLoading: true)
    }

    func refresh() async {
        guard !isLoading else {
            return
        }

        guard !isLoadingMore else {
            return
        }

        await loadProfile(showFullScreenLoading: profile == nil)
    }

    private func loadProfile(showFullScreenLoading: Bool) async {
        if showFullScreenLoading {
            isLoading = true
            initialLoadErrorMessage = nil
        } else {
            refreshErrorMessage = nil
        }

        do {
            let profiles = try await apiClient.fetchProfiles()

            guard let firstProfile = profiles.first else {
                setLoadError(
                    "No profiles found",
                    isInitialLoad: showFullScreenLoading
                )
                isLoading = false
                return
            }

            async let summaryRequest = apiClient.fetchProfileSummary(profileId: firstProfile.id)
            async let contentsRequest = apiClient.fetchContents(
                profileId: firstProfile.id,
                page: 0,
                size: contentsPageSize
            )

            let fetchedSummary = try await summaryRequest
            let firstContentsPage = try await contentsRequest

            profile = firstProfile
            summary = fetchedSummary
            contents = firstContentsPage.content
            currentContentsPage = firstContentsPage.page.number
            totalContentsPages = firstContentsPage.page.totalPages
            loadMoreErrorMessage = nil

            isLoading = false
        } catch {
            setLoadError(
                error.localizedDescription,
                isInitialLoad: showFullScreenLoading
            )
            isLoading = false
        }
    }

    func mediaURL(for mediaItem: APIMediaItem) -> URL {
        apiClient.mediaURL(for: mediaItem)
    }
    
    func loadMoreContentsIfNeeded(currentContent: APIInstagramContent) async {
        guard loadMoreErrorMessage == nil else {
            return
        }

        guard shouldLoadMore(currentContent: currentContent) else {
            return
        }

        await loadMoreContents()
    }

    func loadMoreContentsIfNeeded() async {
        guard loadMoreErrorMessage == nil else {
            return
        }

        guard canLoadMoreContents else {
            return
        }

        await loadMoreContents()
    }

    private func shouldLoadMore(currentContent: APIInstagramContent) -> Bool {
        guard canLoadMoreContents else {
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

    private var canLoadMoreContents: Bool {
        !isLoading &&
            !isLoadingMore &&
            currentContentsPage + 1 < totalContentsPages
    }

    private func loadMoreContents() async {
        guard let profile else {
            return
        }

        isLoadingMore = true
        loadMoreErrorMessage = nil

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
            loadMoreErrorMessage = error.localizedDescription
            isLoadingMore = false
        }
    }

    func dismissRefreshError() {
        refreshErrorMessage = nil
    }

    func retryLoadingMoreContents() async {
        guard canLoadMoreContents else {
            return
        }

        await loadMoreContents()
    }

    private func setLoadError(_ message: String, isInitialLoad: Bool) {
        if isInitialLoad {
            initialLoadErrorMessage = message
        } else {
            refreshErrorMessage = message
        }
    }
}
