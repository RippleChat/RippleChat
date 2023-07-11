//
//  FeedListView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct FeedListView: View {
    @State var feeds: [Feed]
    @StateObject var store = FeedStore(feed: Feed.sampleFeed)
    var feedStores = [FeedStore(feed: Feed.sampleFeed), FeedStore(feed: Feed.sampleFeed2)]
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        Text("FeedListView")
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundColor(.accentColor)
        Text("Hello, world!")
        Button("Save Feed") {
            Task {
                do {
                    for feed in feedStores {
                        try await feed.save(feed: feed.feed)
                    }
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        Spacer()
        NewFeedEntryView()
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView(feeds: [])
    }
}
