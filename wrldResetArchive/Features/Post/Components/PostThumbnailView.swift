//
//  PostThumbnailView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct PostThumbnailView: View {

    let content: APIInstagramContent
    let viewModel: RemoteProfileViewModel
    let namespace: Namespace.ID

    private let aspectRatio: CGFloat = 4.0 / 5.0

    var body: some View {
        NavigationLink {
            if let profile = viewModel.profile {
                PostDetailView(
                    content: content,
                    profile: profile,
                    viewModel: viewModel
                )
                .navigationTransition(
                    .zoom(
                        sourceID: content.id,
                        in: namespace
                    )
                )
            }
        } label: {
            Color.clear
                .aspectRatio(aspectRatio, contentMode: .fit)
                .overlay {
                    if let firstMedia = content.mediaItems.first {
                        ZStack {
                            if firstMedia.mediaType == .image {
                                AsyncImage(url: viewModel.mediaURL(for: firstMedia)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Rectangle()
                                        .fill(.gray.opacity(0.15))
                                }
                            } else {
                                Rectangle()
                                    .fill(.gray.opacity(0.15))

                                Image(systemName: "play.fill")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .shadow(radius: 2)
                            }

                            if content.mediaItems.count > 1 {
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
                    id: content.id,
                    in: namespace
                )
        }
        .buttonStyle(.plain)
    }
}
