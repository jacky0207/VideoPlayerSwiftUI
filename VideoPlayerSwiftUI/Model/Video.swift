//
//  Video.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

struct Video: Decodable {
    var id: String
    var title: String
    var hlsURL: String
    var fullURL: String
    var description: String
    var publishedAt: String
    var author: VideoAuthor
}

struct VideoAuthor: Decodable {
    var id: String
    var name: String
}
