//
//  InstagramMediaItem.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import Foundation

struct InstagramMediaItem: Identifiable {
    let id: String
    let position: Int
    let asset: InstagramAsset

    let caption: String?
    let date: Date?
}
