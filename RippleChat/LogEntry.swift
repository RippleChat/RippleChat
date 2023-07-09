//
//  LogEntry.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import Foundation

struct LogEntry: Codable {
    
    let feedid: String
    let sequenceNumber: Int
    let body: Body
    
    init(feedid: String, sequenceNumber: Int, body: Body) {
        self.feedid = feedid
        self.sequenceNumber = sequenceNumber
        self.body = body
    }
    
}
