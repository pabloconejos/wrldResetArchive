//
//  VideoPlayerModel.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 13/09/2026.
//

import AVFoundation
import Combine

@MainActor
final class VideoPlayerModel: ObservableObject {
    let player: AVPlayer

    init(url: URL) {
        player = AVPlayer(url: url)
    }
}
