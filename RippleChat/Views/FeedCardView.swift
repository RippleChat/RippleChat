//
//  FeedDetailView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 12.07.23.
//

import SwiftUI

struct FeedCardView: View {
    @EnvironmentObject var dataStore: DataStore
    var feed: Feed
    
    private var lastLogEntry: LogEntry {
        if feed.feed.isEmpty {
            return LogEntry()
        } else {
            return feed.feed.last!
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("feedID: \(feed.feedID)")
                Spacer()
                Text("SEQ: \(lastLogEntry.sequenceNumber)")
            }
            Text("Last: \(lastLogEntry.body.value)")
        }
        .padding()
    }
}

struct FeedCardView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCardView(feed: Feed.sampleFeed)
            .environmentObject(DataStore.sampleDataStore)
    }
}
