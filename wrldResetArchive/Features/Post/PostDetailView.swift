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
            VStack(spacing: 0) {

                PostHeaderView()

                postMedia

                PostActionsView()

                postInformation
            }
        }
        .navigationTitle("Publicación")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder // Este bloque no devuelve una única vista de forma tradicional. Construye una composición de vistas de SwiftUI. Porque las dos ramas de normal tienen que devolver el mismo tipo de datos
    private var postMedia: some View {
        if let firstMedia = post.mediaItems.first {
            Image(firstMedia.asset.relativePath)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .background(Color.black)
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

            Text("127 Me gusta")
                .font(.subheadline)
                .fontWeight(.semibold)

            if let description = post.description {
                Text(description)
                    .font(.subheadline)
            }

            Text("Ver los 8 comentarios")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let publishedAt = post.publishedAt {
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
