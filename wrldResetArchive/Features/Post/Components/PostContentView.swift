//
//  PostContentView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 12/09/2026.
//

import SwiftUI

struct PostContentView: View {
    
    let content: APIInstagramContent
    let profile: APIInstagramProfile
    let viewModel: RemoteProfileViewModel
    
    var body: some View {
        
            VStack(spacing: 0) {
                PostHeaderView(profile: profile)

                postMedia

                PostActionsView()

                postInformation
            }
    }

    @ViewBuilder
    private var postMedia: some View {
        if let firstMedia = content.mediaItems.first {
            switch firstMedia.mediaType {
            case .image:
                AsyncImage(url: viewModel.mediaURL(for: firstMedia)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .frame(height: 350)
                }
                .frame(maxWidth: .infinity)
                .background(Color.black)

            case .video:
                RemoteVideoPlayerView(
                    url: viewModel.mediaURL(for: firstMedia)
                )
                .frame(height: 350)

            default:
                ContentUnavailableView(
                    "Vídeo no compatible",
                    systemImage: "video.slash"
                )
                .frame(height: 350)
            }
            
            
            
        } else {
            ContentUnavailableView(
                "Contenido no disponible",
                systemImage: "photo"
            )
            .frame(height: 350)
        }
    }

    private var postInformation: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let description = content.title, !description.isEmpty {
                Text(description)
                    .font(.subheadline)
            }

            if let publishedAt = content.createdAtInstagram {
                Text(
                    publishedAt.formatted(
                        date: .long,
                        time: .omitted
                    )
                )
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}
