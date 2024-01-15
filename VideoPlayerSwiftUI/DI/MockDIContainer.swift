//
//  MockDIContainer.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

class MockDIContainer: DIContainer {
    var dataService: DataService = DataSession(apiService: MockAPISession())
}
