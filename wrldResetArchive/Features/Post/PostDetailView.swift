//
//  PostDetailView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct PostDetailView: View {

    let content: APIInstagramContent
    let profile: APIInstagramProfile
    let viewModel: RemoteProfileViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PostHeaderView(profile: profile)

                postMedia

                PostActionsView()

                postInformation
            }
        }
        .navigationTitle("Publicación")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var postMedia: some View {
        if let firstMedia = content.mediaItems.first {
            if firstMedia.mediaType == .image {
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
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 350)

                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
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
