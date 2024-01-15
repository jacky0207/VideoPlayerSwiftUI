//
//  VideoPlayerSwiftUIApp.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

@main
struct VideoPlayerSwiftUIApp: App {
    let diContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.diContainer, diContainer)
        }
    }
}
