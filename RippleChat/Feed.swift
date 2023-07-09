//
//  Feed.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import Foundation

struct Feed: Codable {
    
    let feed: [LogEntry]
    
}

extension Feed {
    
    static let sampleData: [LogEntry] =
    [
        LogEntry(feedid: "BOB", sequenceNumber: 1, body: Body(tag: "nam", value: "Bob")),
        LogEntry(feedid: "BOB", sequenceNumber: 2, body: Body(tag: "txt", value: "My first post!")),
        LogEntry(feedid: "BOB", sequenceNumber: 3, body: Body(tag: "txt", value: "Welcome Alice"))
    ]
    
}
