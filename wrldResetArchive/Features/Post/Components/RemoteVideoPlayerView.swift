//
//  RemoteVideoPlayerView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 13/09/2026.
//

import AVKit
import SwiftUI

struct RemoteVideoPlayerView: View {
    @StateObject private var model: VideoPlayerModel

    init(url: URL) {
        _model = StateObject(
            wrappedValue: VideoPlayerModel(url: url)
        )
    }

    var body: some View {
        VideoPlayer(player: model.player)
            .onScrollVisibilityChange(threshold: 0.6) { isVisible in
                if isVisible {
                    model.player.play()
                } else {
                    model.player.pause()
                }
            }
            .onDisappear {
                model.player.pause()
            }
    }
}
