//
//  DataStore.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI
import Foundation

@MainActor
class DataStore: ObservableObject {
    @Published var personalID: String
    @Published var friends: [String:Int]
    @Published var feedStores: [FeedStore]
    
    init(personalID: String = "", friends: [String:Int] = [:], feedStores: [FeedStore] = []) {
        self.personalID = personalID
        self.friends = friends
        self.feedStores = feedStores
    }
    
    private func fileURL(for filename: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("\(filename).json")
    }
    
    func savePersonalID() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(personalID)
            let outfile = try fileURL(for: "personalID")
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func saveFriends() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(friends)
            let outfile = try fileURL(for: "friends")
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func loadPersonalID() async throws {
        let task = Task<String, Error> {
            let fileURL = try self.fileURL(for: "personalID")
            let data = try Data(contentsOf: fileURL)
            let personalID = try JSONDecoder().decode(String.self, from: data)
            return personalID
        }
        let personalID = try await task.value
        self.personalID = personalID
    }
    
    func loadFriends() async throws {
        let task = Task<[String:Int], Error> {
            let fileURL = try self.fileURL(for: "friends")
            let data = try Data(contentsOf: fileURL)
            let friends = try JSONDecoder().decode([String:Int].self, from: data)
            return friends
        }
        let friends = try await task.value
        self.friends = friends
    }
    
    func loadFeedStores() async throws {
        let task = Task<[FeedStore], Error> {
            var feedStores: [FeedStore] = []
            for feedStore in self.feedStores {
                try await feedStore.load()
                feedStores.append(feedStore)
            }
            return feedStores
        }
        let feedStores = try await task.value
        self.feedStores = feedStores
    }

    func saveFeedStores() async throws {
        let task = Task {
            for feedStore in self.feedStores {
                try await feedStore.save(feed: feedStore.feed)
            }
        }
        _ = try await task.value
    }
    
    
    
}


extension DataStore {
    static let sampleDataStore = DataStore(personalID: "BOB", friends: SettingsView_Previews.friends, feedStores: [FeedStore(feed: Feed.sampleFeed), FeedStore(feed: Feed.sampleFeed2)])
}
