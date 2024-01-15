//
//  DIContainer.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import SwiftUI
import Combine

protocol DIContainer {
    var dataService: DataService { get }
}

class AppDIContainer: DIContainer {
    var dataService: DataService = DataSession(apiService: APISession())
}

struct DIContainerKey: EnvironmentKey {
    static var defaultValue: DIContainer = AppDIContainer()
}

// MARK: - EnvironmentValues
extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
