//
//  APISession.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import Combine

class APISession: APIService {
    func videos() -> AnyPublisher<[Video], APIHelperError> {
        return APIHelper.shared.get(urlString: "http://localhost:4000/videos")
    }
}
