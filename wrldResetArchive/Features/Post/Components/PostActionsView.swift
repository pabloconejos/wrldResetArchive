//
//  PostActionsView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 26/07/2026.
//

import SwiftUI

struct PostActionsView: View {

    @State private var isLiked = false
    @State private var isSaved = false

    var body: some View {
        HStack(spacing: 18) {

            Button {
                isLiked.toggle()
            } label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundStyle(isLiked ? .red : .primary)
            }

            Button {
                // Comentarios
            } label: {
                Image(systemName: "bubble.right")
                    .font(.title2)
                    .foregroundStyle(.primary)
            }

            Button {
                // Compartir
            } label: {
                Image(systemName: "paperplane")
                    .font(.title2)
                    .foregroundStyle(.primary)
            }

            Spacer()

            Button {
                isSaved.toggle()
            } label: {
                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    .font(.title2)
                    .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}
