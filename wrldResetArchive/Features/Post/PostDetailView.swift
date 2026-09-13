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
            PostContentView(
                content: content,
                profile: profile,
                viewModel: viewModel
            )
        }
        .navigationTitle("Publicación")
        .navigationBarTitleDisplayMode(.inline)
    }
}
