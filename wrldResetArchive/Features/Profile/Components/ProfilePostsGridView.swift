//
//  ProfilePostsGridView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfilePostsGridView: View {

    let contents: [APIInstagramContent]
    let viewModel: RemoteProfileViewModel

    @Namespace private var postTransition

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 1),
        count: 3
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(contents) { content in
                PostThumbnailView(
                    content: content,
                    viewModel: viewModel,
                    namespace: postTransition
                )
            }
        }
    }
}
