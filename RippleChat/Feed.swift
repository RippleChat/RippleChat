//
//  Feed.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import Foundation

struct Feed: Codable {
    
    let feedID: String
    let feed: [LogEntry]
    
    init(feedID: String = "", feed: [LogEntry] = []) {
        self.feedID = feedID
        self.feed = feed
    }
    
    func getLastLogEntry() -> LogEntry {
        if self.feed.isEmpty {
            return LogEntry()
        } else {
            return self.feed.last!
        }
    }
    
}

extension Feed {
    
    static let sampleData: [LogEntry] =
    [
        LogEntry(feedid: "BOB", sequenceNumber: 1, body: Body(tag: Apps.nam, value: "Bob")),
        LogEntry(feedid: "BOB", sequenceNumber: 2, body: Body(tag: Apps.txt, value: "My first post!")),
        LogEntry(feedid: "BOB", sequenceNumber: 3, body: Body(tag: Apps.txt, value: "Welcome Alice"))
    ]
    
    static let sampleData2: [LogEntry] =
    [
        LogEntry(feedid: "ALI", sequenceNumber: 1, body: Body(tag: Apps.nam, value: "Alice")),
        LogEntry(feedid: "ALI", sequenceNumber: 2, body: Body(tag: Apps.txt, value: "Alice' first post!")),
        LogEntry(feedid: "ALI", sequenceNumber: 3, body: Body(tag: Apps.txt, value: "Welcome Bob")),
        LogEntry(feedid: "ALI", sequenceNumber: 4, body: Body(tag: Apps.txt, value: "Whaddup DAWG"))
    ]
    
    static let sampleFeed: Feed = Feed(feedID: "BOB", feed: sampleData)
    static let sampleFeed2: Feed = Feed(feedID: "ALI", feed: sampleData2)
    
}
