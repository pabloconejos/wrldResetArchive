//
//  InstagramPost.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import Foundation

struct InstagramPost: Identifiable {
    let id: String
    let profileID: String

    let kind: InstagramPostKind
    let description: String?
    let publishedAt: Date?

    let mediaItems: [InstagramMediaItem]

    let isArchived: Bool
}

enum InstagramPostKind {
    case post
    case carousel
    case reel
    case igtv
    case story
}
