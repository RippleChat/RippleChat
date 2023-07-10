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
    
}

extension Feed {
    
    static let sampleData: [LogEntry] =
    [
        LogEntry(feedid: "BOB", sequenceNumber: 1, body: Body(tag: "nam", value: "Bob")),
        LogEntry(feedid: "BOB", sequenceNumber: 2, body: Body(tag: "txt", value: "My first post!")),
        LogEntry(feedid: "BOB", sequenceNumber: 3, body: Body(tag: "txt", value: "Welcome Alice"))
    ]
    
    static let sampleFeed: Feed = Feed(feedID: "BOB", feed: sampleData)
    
}
