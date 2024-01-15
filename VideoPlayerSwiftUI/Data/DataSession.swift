//
//  DataSession.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import Combine

class DataSession: DataService {
    var apiService: APIService
    
    required init(apiService: APIService) {
        self.apiService = apiService
    }

    func videos() -> AnyPublisher<[Video], APIHelperError> {
        return apiService.videos()
    }
}
