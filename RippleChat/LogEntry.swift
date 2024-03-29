//
//  LogEntry.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import Foundation

struct LogEntry: Codable, Identifiable {
    
    var id: UUID = UUID()
    
    let feedid: String
    let sequenceNumber: Int
    let body: Bodyy
    
    init(feedid: String = "", sequenceNumber: Int = 0, body: Bodyy = Bodyy()) {
        self.feedid = feedid
        self.sequenceNumber = sequenceNumber
        self.body = body
    }
    
}

extension LogEntry {
    static let sampleLogEntry = LogEntry(feedid: "BOB", sequenceNumber: 2, body: Bodyy(tag: Apps.txt, value: "My first post!"))
}
