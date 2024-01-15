//
//  ViewModel.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-15.
//

import Combine

open class ViewModel {
    var diContainer: DIContainer
    var concellables = Set<AnyCancellable>()

    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    var dataService: DataService {
        return diContainer.dataService
    }
}
