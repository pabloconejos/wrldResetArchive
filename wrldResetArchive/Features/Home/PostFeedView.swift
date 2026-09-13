//
//  PostFeedView.swift
//  wrldResetArchive
//

import SwiftUI

struct PostFeedView: View {

    let profile: APIInstagramProfile
    @ObservedObject var viewModel: RemoteProfileViewModel
    @State private var shuffledContents: [APIInstagramContent] = []

    private var contents: [APIInstagramContent] {
        viewModel.contents.filter { content in
            content.contentType == .post || content.contentType == .reel
        }
    }

    private var contentIDs: [String] {
        contents.map(\.id)
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(Array(shuffledContents.enumerated()), id: \.element.id) { index, content in
                    PostContentView(
                        content: content,
                        profile: profile,
                        viewModel: viewModel
                    )
                    .task {
                        guard index >= shuffledContents.count - 6 else {
                            return
                        }

                        await viewModel.loadMoreContentsIfNeeded()
                    }
                }

                PaginationFooterView(
                    isLoading: viewModel.isLoadingMore,
                    errorMessage: viewModel.loadMoreErrorMessage,
                    retry: viewModel.retryLoadingMoreContents
                )
            }
        }
        .refreshable {
            await viewModel.refresh()
            shuffledContents = contents.shuffled()
        }
        .onAppear {
            synchronizeShuffledContents()
        }
        .onChange(of: contentIDs) { _, _ in
            synchronizeShuffledContents()
        }
    }

    private func synchronizeShuffledContents() {
        guard !contents.isEmpty else {
            shuffledContents = []
            return
        }

        guard !shuffledContents.isEmpty else {
            shuffledContents = contents.shuffled()
            return
        }

        let availableIDs = Set(contents.map(\.id))
        shuffledContents.removeAll { !availableIDs.contains($0.id) }

        let displayedIDs = Set(shuffledContents.map(\.id))
        let newContents = contents.filter { !displayedIDs.contains($0.id) }

        shuffledContents.append(contentsOf: newContents.shuffled())
    }
}
