//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.diContainer) var diContainer
    
    var body: some View {
        VideoPlayerView(viewModel: VideoPlayerViewModel(diContainer: diContainer))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
