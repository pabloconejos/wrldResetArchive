//
//  PostDetailView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct PostDetailView: View {
    let initialContent: APIInstagramContent
    let profile: APIInstagramProfile
    let viewModel: RemoteProfileViewModel

    @State private var scrollPosition = ScrollPosition(idType: String.self)

    init(
        content: APIInstagramContent,
        profile: APIInstagramProfile,
        viewModel: RemoteProfileViewModel
    ) {
        initialContent = content
        self.profile = profile
        self.viewModel = viewModel
    }

    private var feedContents: [APIInstagramContent] {
        viewModel.contents.filter { content in
            content.contentType == .post || content.contentType == .reel
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(feedContents) { content in
                    PostDetailItemView(
                        content: content,
                        profile: profile,
                        viewModel: viewModel
                    )
                    .id(content.id)
                    .task {
                        await viewModel.loadMoreContentsIfNeeded(
                            currentContent: content
                        )
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition($scrollPosition, anchor: .top)
        .navigationTitle("Publicación")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: initialContent.id) {
            scrollPosition.scrollTo(id: initialContent.id, anchor: .top)
        }
    }
}
