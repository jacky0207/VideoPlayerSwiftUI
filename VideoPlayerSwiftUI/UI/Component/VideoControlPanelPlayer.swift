//
//  VideoControlPanelPlayer.swift
//  VideoPlayerSwiftUI
//
//  Created by Jacky Lam on 2024-01-14.
//

import SwiftUI
import AVKit

protocol VideoControlPanelPlayerProtocol {
    func play()
    func pause()
    func previous()
    func next()
}

struct VideoControlPanelPlayer: View, VideoControlPanelPlayerProtocol {
    var player: AVPlayer?
    var isPreviousEnabled: Bool
    var previousAction: () -> Void
    var isNextEnabled: Bool
    var nextAction: () -> Void
    @State private var isControlPanelPresented: Bool = false
    @State private var isPlaying: Bool = false
    @State private var size: CGSize = .zero

    init(
        url: URL?,
        isPreviousEnabled: Bool,
        previousAction: @escaping () -> Void,
        isNextEnabled: Bool,
        nextAction: @escaping () -> Void
    ) {
        if let url = url {
            self.player = AVPlayer(url: url)
        }
        self.isPreviousEnabled = isPreviousEnabled
        self.previousAction = previousAction
        self.isNextEnabled = isNextEnabled
        self.nextAction = nextAction
    }

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .disabled(true)
                .modifier(SizeReaderViewModifer(size: $size))

            VideoPlayerControlPanel(
                isPresented: isControlPanelPresented,
                isPlaying: isPlaying,
                playAction: isPlaying ? pause : play,
                isPreviousEnabled: isPreviousEnabled,
                previousAction: previous,
                isNextEnabled: isNextEnabled,
                nextAction: next
            )
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())  // tap space works with transparent background
            .onTapGesture {
                isControlPanelPresented.toggle()
            }
        }
    }

    func play() {
        if isPlaying {
            return
        }
        player?.play()
        isPlaying.toggle()
    }

    func pause() {
        if !isPlaying {
            return
        }
        player?.pause()
        isPlaying.toggle()
    }

    func previous() {
        if isPlaying {
            pause()
        }
        previousAction()
    }

    func next() {
        if isPlaying {
            pause()
        }
        nextAction()
    }
}

fileprivate struct VideoPlayerControlPanel: View {
    var isPresented: Bool
    var isPlaying: Bool
    var playAction: () -> Void
    var isPreviousEnabled: Bool
    var previousAction: () -> Void
    var isNextEnabled: Bool
    var nextAction: () -> Void

    var body: some View {
        HStack(spacing: 30) {
            if !isPresented {
                EmptyView()
            } else {
                previousButton()
                playButton()
                nextButton()
            }
        }
    }

    func playButton() -> some View {
        Button(action: playAction) {
            Image(isPlaying ? "pause" : "play")
        }
        .buttonStyle(VideoControlPanelButtonStyle(width: 80))
    }

    func previousButton() -> some View {
        Button(action: previousAction) {
            Image("previous")
        }
        .disabled(!isPreviousEnabled)
        .buttonStyle(VideoControlPanelButtonStyle(width: 60))
    }

    func nextButton() -> some View {
        Button(action: nextAction) {
            Image("next")
        }
        .disabled(!isNextEnabled)
        .buttonStyle(VideoControlPanelButtonStyle(width: 60))
    }
}

fileprivate struct SizeReaderViewModifer: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear  // transparent with the ui component size
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

fileprivate struct VideoControlPanelButtonStyle: ButtonStyle {
    var width: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: width)
            .background(Circle().fill(Color.white))
            .background(Circle().stroke(Color.black, lineWidth: 1.0))
    }
}

struct VideoControlPanelPlayer_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            VideoControlPanelPlayer(
                url: URL(string: "https://d140vvwqovffrf.cloudfront.net/media/5e87b9a811599/full/720.mp4"),
                isPreviousEnabled: true,
                previousAction: {},
                isNextEnabled: true,
                nextAction: {}
            )
            .frame(height: 300)
            .previewLayout(.sizeThatFits)

            VideoControlPanelPlayer(
                url: URL(string: ""),
                isPreviousEnabled: true,
                previousAction: {},
                isNextEnabled: true,
                nextAction: {}
            )
            .frame(height: 300)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Nil URL")

            VideoControlPanelPlayer(
                url: URL(string: "https://d140vvwqovffrf.cloudfront.net/media/5e87b9a811599/full/720.mp4"),
                isPreviousEnabled: false,
                previousAction: {},
                isNextEnabled: true,
                nextAction: {}
            )
            .frame(height: 300)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Head")

            VideoControlPanelPlayer(
                url: URL(string: "https://d140vvwqovffrf.cloudfront.net/media/5e87b9a811599/full/720.mp4"),
                isPreviousEnabled: true,
                previousAction: {},
                isNextEnabled: false,
                nextAction: {}
            )
            .frame(height: 300)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Tail")
        }
    }
}
