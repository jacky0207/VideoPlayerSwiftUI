//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

import SwiftUI

struct VideoPlayerView: View, VideoPlayerViewProtocol {
    @StateObject var viewModel: VideoPlayerViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                VideoControlPanelPlayer(
                    url: URL(string: viewModel.videoPlayerList.currVideo?.fullURL ?? ""),
                    isPreviousEnabled: viewModel.videoPlayerList.hasPrevious,
                    previousAction: { viewModel.videoPlayerList.previous() },
                    isNextEnabled: viewModel.videoPlayerList.hasNext,
                    nextAction: { viewModel.videoPlayerList.next() }
                )
                .frame(height: 300)
                Text(viewModel.videoPlayerList.currVideo?.title ?? "")
                Text(viewModel.videoPlayerList.currVideo?.author.name ?? "")
                MarkdownText(viewModel.videoPlayerList.currVideo?.description ?? "")
            }
        }
        .onAppear(perform: viewModel.fetchVideos)
    }
}

struct VideoPlayerView_Preview: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(viewModel: VideoPlayerViewModel(diContainer: MockDIContainer()))
    }
}
