//
//  FeedStore.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import SwiftUI

@MainActor
class FeedStore: ObservableObject {
    
    @Published var feed: Feed
    
    init(feed: Feed) {
        self.feed = feed
    }
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("\(feed.feedID).json")
    }
    
    func load() async throws {
        let task = Task<Feed, Error> {
            let fileURL = try self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return Feed()
            }
            let feed = try JSONDecoder().decode(Feed.self, from: data)
            return feed
        }
        let feed = try await task.value
        self.feed = feed
    }
    
    func save(feed: Feed) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(feed)
            let outfile = try self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
