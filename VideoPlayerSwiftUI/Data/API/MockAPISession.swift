//
//  MockAPISession.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import Combine

class MockAPISession: APIService {
    func videos() -> AnyPublisher<[Video], APIHelperError> {
        return Just(ModelData().videos)
            .setFailureType(to: APIHelperError.self)
            .eraseToAnyPublisher()
    }
}
