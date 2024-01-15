//
//  VideoPlayerViewProtocol.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

protocol VideoPlayerViewProtocol {

}

protocol VideoPlayerViewModelProtocol {
    var videoPlayerList: VideoPlayerList { get set }
    func fetchVideos()
}
