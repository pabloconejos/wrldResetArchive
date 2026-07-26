//
//  PostThumbnailView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct PostThumbnailView: View {

    let post: InstagramPost
    let namespace: Namespace.ID

    private let aspectRatio: CGFloat = 4.0 / 5.0

    var body: some View {
        
        NavigationLink {

            PostDetailView(post: post)
                    .navigationTransition(
                        .zoom(
                            sourceID: post.id,
                            in: namespace
                        )
                    )

        } label: {

            Color.clear
                .aspectRatio(aspectRatio, contentMode: .fit)
                .overlay {
                    if let firstMedia = post.mediaItems.first {
                        ZStack {
                            Image(firstMedia.asset.relativePath)
                                .resizable()
                                .scaledToFill()

                            if post.mediaItems.count > 1 {
                                Image(systemName: "square.on.square.fill")
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .frame(
                                        maxWidth: .infinity,
                                        maxHeight: .infinity,
                                        alignment: .topTrailing
                                    )
                                    .shadow(radius: 2)
                            }
                        }
                    } else {
                        ContentUnavailableView(
                            "Sin contenido",
                            systemImage: "photo"
                        )
                    }
                }
                .clipped()
                .matchedTransitionSource(
                    id: post.id,
                    in: namespace
                )

        }
        
        
    }
}
