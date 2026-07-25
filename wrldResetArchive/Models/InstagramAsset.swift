//
//  InstagramAsset.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import Foundation

struct InstagramAsset: Identifiable {
    let id: String
    let relativePath: String
    let type: InstagramAssetType

    let subtitlesPath: String?
}

enum InstagramAssetType {
    case image
    case video
    case subtitles
    case unknown
}
