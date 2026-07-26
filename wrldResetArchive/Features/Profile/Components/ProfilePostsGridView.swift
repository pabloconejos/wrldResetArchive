//
//  ProfilePostsGridView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfilePostsGridView: View {

    let posts: [InstagramPost]
    let repository: InstagramRepository
    
    @Namespace private var postTransition
    
    private let postAspectRatio: CGFloat = 4.0 / 5.0

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 1),
        count: 3
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(posts) { post in
                PostThumbnailView(
                    post: post,
                    repository: repository,
                    namespace: postTransition
                )
            }
        }
    }
}
