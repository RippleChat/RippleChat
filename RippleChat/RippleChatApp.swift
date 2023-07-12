//
//  RippleChatApp.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 05.07.23.
//

import SwiftUI

@main
struct RippleChatApp: App {
    @StateObject private var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            ContentView() {
                Task {
                    do {
                        try await dataStore.savePersonalID()
                        try await dataStore.savePersonalFeed()
                        try await dataStore.saveFriends()
                        try await dataStore.saveFeedStores()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .environmentObject(dataStore)
                .task {
                    do {
                        try await dataStore.loadPersonalID()
                        try await dataStore.loadPersonalFeed()
                        try await dataStore.loadFriends()
                        try await dataStore.loadFeedStores()
                    } catch {
                        // Handle the error
                        print("Error loading data: \(error)")
                        fatalError(error.localizedDescription)
                    }
                }
            
        }
    }
}
