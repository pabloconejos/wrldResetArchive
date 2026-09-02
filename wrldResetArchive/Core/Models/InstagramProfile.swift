//
//  InstagramProfile.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 26/07/2026.
//

import Foundation

struct InstagramProfile: Identifiable {
    let id: String

    let username: String
    let displayName: String?
    let biography: String?

    let profileImagePath: String?

    let followersCount: Int?
    let followingCount: Int?

    let externalURL: URL?
}
