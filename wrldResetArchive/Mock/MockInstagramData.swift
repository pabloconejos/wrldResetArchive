//
//  MockInstagramData.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import Foundation

struct MockInstagramData {

    static let posts: [InstagramPost] = [

        InstagramPost(
            id: "post_1",
            kind: .post,
            description: "Noruega 🇳🇴",
            publishedAt: Date(),
            mediaItems: [
                InstagramMediaItem(
                    id: "media_1",
                    position: 0,
                    asset: InstagramAsset(
                        id: "asset_1",
                        relativePath: "1",
                        type: .image,
                        subtitlesPath: nil
                    ),
                    caption: nil,
                    date: Date()
                ),
                InstagramMediaItem(
                    id: "media_1",
                    position: 0,
                    asset: InstagramAsset(
                        id: "asset_1",
                        relativePath: "1",
                        type: .image,
                        subtitlesPath: nil
                    ),
                    caption: nil,
                    date: Date()
                )
            ],
            isArchived: false
        )

    ]
}
