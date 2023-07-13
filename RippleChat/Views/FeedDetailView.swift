//
//  FeedDetailView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 13.07.23.
//

import SwiftUI

struct FeedDetailView: View {
    @EnvironmentObject var dataStore: DataStore
    var feed: Feed
    
    init(feed: Feed) {
        self.feed = feed
    }
    
    var body: some View {
        NavigationStack {
            List(feed.feed) { logEntry in
                LogEntryView(logEntry: logEntry)
            }
        }
        .navigationTitle("Feed: \(feed.feedID)")
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailView(feed: Feed.sampleFeed)
            .environmentObject(DataStore.sampleDataStore)
    }
}
