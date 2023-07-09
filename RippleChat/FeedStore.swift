//
//  FeedStore.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import SwiftUI

@MainActor
class FeedStore: ObservableObject {
    
    @Published var feed: [LogEntry] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("feed.data")
    }
    
    func load() async throws {
        let task = Task<[LogEntry], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let logEntries = try JSONDecoder().decode([LogEntry].self, from: data)
            return logEntries
        }
        let feed = try await task.value
        self.feed = feed
    }
    
    func save(feed: [LogEntry]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(feed)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
