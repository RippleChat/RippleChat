//
//  RippleChatApp.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 05.07.23.
//

import SwiftUI

@main
struct RippleChatApp: App {
    @State private var currentView: CurrentView = CurrentView.feeds
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Peers") {}
                        
                    }
                }
        }
    }
}

enum CurrentView {
    case peers
    case feeds
    case friends
    case settings
}
