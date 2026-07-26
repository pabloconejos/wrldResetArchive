//
//  MockInstagramData.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import Foundation

struct MockInstagramData {

    static let profiles: [InstagramProfile] = [
        InstagramProfile(
            id: "profile_1",
            username: "pabloconejos",
            displayName: "Pablo Conejos",
            biography: "Mi archivo de Instagram",
            location: "Valencia",
            profileImageName: "profile"
        )
    ]

    static let posts: [InstagramPost] = [
        InstagramPost(
            id: "post_1",
            profileID: "profile_1",
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
                )
            ],
            isArchived: false
        )
    ]
}

extension InstagramRepository {

    static let mock = InstagramRepository(
        profiles: MockInstagramData.profiles,
        posts: MockInstagramData.posts
    )
}
