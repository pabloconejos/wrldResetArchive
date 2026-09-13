//
//  PostFeedView.swift
//  wrldResetArchive
//

import SwiftUI

struct PostFeedView: View {

    let profile: APIInstagramProfile
    @ObservedObject var viewModel: RemoteProfileViewModel

    private var contents: [APIInstagramContent] {
        viewModel.contents.filter { content in
            content.contentType == .post || content.contentType == .reel
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(contents) { content in
                    PostDetailItemView(
                        content: content,
                        profile: profile,
                        viewModel: viewModel
                    )
                    .task {
                        await viewModel.loadMoreContentsIfNeeded(
                            currentContent: content
                        )
                    }
                }

                if viewModel.isLoadingMore {
                    ProgressView()
                        .padding()
                }
            }
        }
        .refreshable {
            await viewModel.refresh()
        }
    }
}
