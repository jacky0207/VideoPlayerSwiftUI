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
        VStack(spacing: 4) {
            VideoControlPanelPlayer(
                url: URL(string: viewModel.videoPlayerList.currVideo?.fullURL ?? ""),
                isPreviousEnabled: viewModel.videoPlayerList.hasPrevious,
                previousAction: { viewModel.videoPlayerList.previous() },
                isNextEnabled: viewModel.videoPlayerList.hasNext,
                nextAction: { viewModel.videoPlayerList.next() }
            )
            .frame(height: 300)
            ScrollView {
                VideoPlayerDetailSecionView(video: viewModel.videoPlayerList.currVideo)
            }
        }
        .onAppear(perform: viewModel.fetchVideos)
    }
}

struct VideoPlayerDetailSecionView: View {
    var video: Video?

    var body: some View {
        VStack(alignment: .leading) {
            Text(video?.title ?? "")
                .modifier(VideoPlayerTitleTextStyle())
            Text(video?.author.name ?? "")
                .modifier(VideoPlayerAuthorTextStyle())
            MarkdownText(video?.description ?? "")
        }
        .padding(.all, 10)
    }
}

struct VideoPlayerTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 16, weight: .medium))
            .foregroundColor(Color.black)
    }
}

struct VideoPlayerAuthorTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 14, weight: .regular))
            .foregroundColor(Color.gray)
    }
}

struct VideoPlayerView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            VideoPlayerView(viewModel: VideoPlayerViewModel(diContainer: MockDIContainer()))
            ScrollView {
                VideoPlayerDetailSecionView(video: ModelData().videos[0])
            }
            .previewLayout(.sizeThatFits)
        }
    }
}
