//
//  DataSession.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

class DataSession: DataService {
    var apiService: APIService
    
    required init(apiService: APIService) {
        self.apiService = apiService
    }
}
