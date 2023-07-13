//
//  LogEntryView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 12.07.23.
//

import SwiftUI

struct LogEntryView: View {
    var logEntry: LogEntry
    
    init(logEntry: LogEntry) {
        self.logEntry = logEntry
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("SEQ: \(logEntry.sequenceNumber)")
                    Spacer()
                    Text("Tag: \(logEntry.body.tag)")
                }
                HStack {
                    Text("Value: \(logEntry.body.value)")
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct LogEntryView_Previews: PreviewProvider {
    static var previews: some View {
        LogEntryView(logEntry: LogEntry.sampleLogEntry)
    }
}
