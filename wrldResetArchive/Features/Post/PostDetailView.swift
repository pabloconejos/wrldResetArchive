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

    @State private var scrollPosition: String?

    init(
        content: APIInstagramContent,
        profile: APIInstagramProfile,
        viewModel: RemoteProfileViewModel
    ) {
        initialContent = content
        self.profile = profile
        self.viewModel = viewModel
        _scrollPosition = State(initialValue: content.id)
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.contents) { content in
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
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition, anchor: .top)
    }
}
