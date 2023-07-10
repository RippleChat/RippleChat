//
//  RippleChatApp.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 05.07.23.
//

import SwiftUI

@main
struct RippleChatApp: App {
    //@State private var currentView: CurrentView = CurrentView.feeds
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {}) {
                            VStack {
                                Label("Discovery", systemImage: "dot.radiowaves.left.and.right")
                                Text("Discovery")
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            VStack {
                                Label("Discovery", systemImage: "person.2")
                                Text("Feeds")
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            VStack {
                                Label("Discovery", systemImage: "gear")
                                Text("Settings")
                            }
                        }
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
