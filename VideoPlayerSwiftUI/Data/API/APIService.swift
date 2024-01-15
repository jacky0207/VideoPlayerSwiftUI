//
//  APIService.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import Combine

protocol APIService {
    func videos() -> AnyPublisher<[Video], APIHelperError>
}
