//
//  VideoPlayerListTests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Jacky Lam on 2024-01-15.
//

import XCTest
@testable import VideoPlayerSwiftUI

final class VideoPlayerListTests: XCTestCase {
    var list = VideoPlayerList(videos: [
        Video(id: "0", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2019-12-15T22:17:00.000Z", author: VideoAuthor(id: "", name: "")),
        Video(id: "1", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2018-12-14T21:09:00.000Z", author: VideoAuthor(id: "", name: "")),
    ])

    override func setUpWithError() throws {
        list = VideoPlayerList(videos: [
            Video(id: "0", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2019-12-15T22:17:00.000Z", author: VideoAuthor(id: "", name: "")),
            Video(id: "1", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2018-12-14T21:09:00.000Z", author: VideoAuthor(id: "", name: "")),
        ])
    }

    override func tearDownWithError() throws {

    }

    func testVideoPlayerList_SetVideos() throws {
        list.setVideos([
            Video(id: "0", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2019-12-15T22:17:00.000Z", author: VideoAuthor(id: "", name: "")),
            Video(id: "1", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2018-12-14T21:09:00.000Z", author: VideoAuthor(id: "", name: "")),
        ])
        XCTAssertEqual(list.videos.count, 2)
    }

    func testVideoPlayerList_SetVideos_Ordered() throws {
        list.setVideos([
            Video(id: "0", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2019-12-15T22:17:00.000Z", author: VideoAuthor(id: "", name: "")),
            Video(id: "1", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2018-12-14T21:09:00.000Z", author: VideoAuthor(id: "", name: "")),
        ])
        XCTAssertEqual(list.currVideo?.id, "1")
    }

    func testVideoPlayerList_SetVideosWithUnknownDateFormat_Unordered() throws {
        list.setVideos([
            Video(id: "0", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2019-12-15 22:17:00.000Z", author: VideoAuthor(id: "", name: "")),
            Video(id: "1", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2018-12-14 21:09:00.000Z", author: VideoAuthor(id: "", name: "")),
        ])
        XCTAssertEqual(list.currVideo?.id, "0")
    }

    func testVideoPlayerList_SetVideos_ResetIndex() throws {
        list.next()
        XCTAssertEqual(list.currIndex, 1)
        list.setVideos([
            Video(id: "0", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2019-12-15T22:17:00.000Z", author: VideoAuthor(id: "", name: "")),
            Video(id: "1", title: "", hlsURL: "", fullURL: "", description: "", publishedAt: "2018-12-14T21:09:00.000Z", author: VideoAuthor(id: "", name: "")),
        ])
        XCTAssertEqual(list.currIndex, 0)
    }

    func testVideoPlayerList_PreviousAndNext() throws {
        list.previous()
        XCTAssertEqual(list.currIndex, 0)
        list.next()
        XCTAssertEqual(list.currIndex, 1)
        list.next()
        XCTAssertEqual(list.currIndex, 1)
        list.previous()
        XCTAssertEqual(list.currIndex, 0)
    }

    func testVideoPlayerList_HasPrevious() throws {
        XCTAssertFalse(list.hasPrevious)
        list.next()
        XCTAssertTrue(list.hasPrevious)
    }

    func testVideoPlayerList_HasNext() throws {
        XCTAssertTrue(list.hasNext)
        list.next()
        XCTAssertFalse(list.hasNext)
    }
}
