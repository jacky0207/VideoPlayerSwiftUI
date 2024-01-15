//
//  VideoPlayerViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

import Combine

class VideoPlayerViewModel: ViewModel, ObservableObject, VideoPlayerViewModelProtocol {
    @Published var videoPlayerList: VideoPlayerList = VideoPlayerList(videos: [])
    @Published var title: String = ""

    func fetchVideos() {
        dataService.videos()
            .sink(
                receiveCompletion: { completion in
                    guard case .failure = completion else {
                        return
                    }
                    self.videoPlayerList.setVideos([])  // ignore error handling in this moment
                },
                receiveValue: { videos in
                    self.videoPlayerList.setVideos(videos)
                }
            )
            .store(in: &concellables)
        self.videoPlayerList.setVideos(ModelData().videos)
    }
}
