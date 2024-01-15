//
//  APIHelper.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import Foundation
import Combine

enum APIHelperError: Error {
    case unknown
    case urlNotFound
    case decode
}

extension APIHelperError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown"
        case .urlNotFound:
            return "Url is not valid"
        case .decode:
            return "Decode failure for output"
        }
    }
}

open class APIHelper {
    static let shared = APIHelper()
    var decoder = JSONDecoder()

    func get<Output>(urlString: String) -> AnyPublisher<Output, APIHelperError> where Output: Decodable {
        guard let url = URL(string: urlString) else {
            return Fail(error: APIHelperError.urlNotFound)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .mapError { _ in APIHelperError.unknown }
            .map { data, response -> AnyPublisher<Output, APIHelperError> in
                return Just(data)
                    .decode(type: Output.self, decoder: self.decoder)
                    .mapError { error in APIHelperError.decode }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
