//
//  VideoPlayerList.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

import Foundation

struct VideoPlayerList {
    init(videos: [Video]) {
        self.videos = videos
    }

    private(set) var videos: [Video] = [] {
        didSet {
            currIndex = 0
        }
    }

    mutating func setVideos(_ videos: [Video]) {
        self.videos = videos.sorted(by: {
            guard let date1 = DateUtil.shared.date(from: $0.publishedAt),
                  let date2 = DateUtil.shared.date(from: $1.publishedAt) else {
                return false
            }
            return date1 < date2
        })  // old to new
    }

    var currIndex: Int = 0
    var currVideo: Video? {
        if videos.count == 0 {
            return nil
        }
        return videos[currIndex]
    }

    var hasPrevious: Bool {
        return currIndex > 0
    }

    mutating func previous() {
        if currIndex == 0 {
            return
        }
        currIndex -= 1
    }

    var hasNext: Bool {
        return currIndex < videos.count - 1
    }

    mutating func next() {
        if currIndex == videos.count - 1 {
            return
        }
        currIndex += 1
    }
}
