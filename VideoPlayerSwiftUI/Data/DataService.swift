//
//  DataService.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

protocol DataService: APIService {
    var apiService: APIService { get set }
    init(apiService: APIService)
}
