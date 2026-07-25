//
//  ProfilePostsGridView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfilePostsGridView: View {

    private let posts = [
        ProfilePost(imageName: "1"),
        ProfilePost(imageName: "6"),
        ProfilePost(imageName: "3"),
        ProfilePost(imageName: "4"),
        ProfilePost(imageName: "5"),
        ProfilePost(imageName: "6"),
        ProfilePost(imageName: "8"),
        ProfilePost(imageName: "7"),
        ProfilePost(imageName: "3"),
        ProfilePost(imageName: "4"),
        ProfilePost(imageName: "5"),
        ProfilePost(imageName: "1")
    ]
    
    private let postAspectRatio: CGFloat = 4.0 / 5.0

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 1),
        count: 3
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(posts) { post in
                Color.clear
                    .aspectRatio(postAspectRatio, contentMode: .fit)
                    .overlay {
                        Image(post.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                    .clipped()
            }
        }
    }
}
