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
    @Published var personalFeed: Feed
    @Published var friends: [String:Int]
    @Published var feedStores: [FeedStore]
    
    
    init(personalID: String = "", personalFeed: Feed = Feed(), friends: [String:Int] = [:], feedStores: [FeedStore] = []) {
        self.personalID = personalID
        self.friends = friends
        self.feedStores = feedStores
        self.personalFeed = personalFeed
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
            guard let data = try? Data(contentsOf: fileURL) else {
                return ""
            }
            let personalID = try JSONDecoder().decode(String.self, from: data)
            return personalID
        }
        let personalID = try await task.value
        self.personalID = personalID
    }
    
    func loadFriends() async throws {
        let task = Task<[String:Int], Error> {
            let fileURL = try self.fileURL(for: "friends")
            guard let data = try? Data(contentsOf: fileURL) else {
                return [:]
            }
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
    
    func savePersonalFeed() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(personalFeed)
            let outfile = try fileURL(for: "personalFeed")
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    func loadPersonalFeed() async throws {
        let task = Task<Feed, Error> {
            let fileURL = try self.fileURL(for: "personalFeed")
            guard let data = try? Data(contentsOf: fileURL) else {
                return Feed(feedID: self.personalID)
            }
            let personalFeed = try JSONDecoder().decode(Feed.self, from: data)
            return personalFeed
        }
        let personalFeed = try await task.value
        self.personalFeed = personalFeed
    }
    
    
    
}


extension DataStore {
    static let sampleDataStore = DataStore(personalID: "BOB", friends: SettingsView_Previews.friends, feedStores: [FeedStore(feed: Feed.sampleFeed), FeedStore(feed: Feed.sampleFeed2)])
}
