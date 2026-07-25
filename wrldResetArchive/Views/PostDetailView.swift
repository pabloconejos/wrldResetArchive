//
//  PostDetailView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct PostDetailView: View {

    let post: InstagramPost

    var body: some View {
        ScrollView {

            if let firstMedia = post.mediaItems.first {
                Image(firstMedia.asset.relativePath)
                    .resizable()
                    .scaledToFit()
            }

            VStack(alignment: .leading, spacing: 12) {

                if let description = post.description {
                    Text(description)
                }

                if let publishedAt = post.publishedAt {
                    Text(publishedAt.formatted())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

            }
            .padding()

        }
        .navigationTitle("Publicación")
        .navigationBarTitleDisplayMode(.inline)
    }
}
