//
//  FeedListView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct FeedListView: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        Text("FeedListView")
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundColor(.accentColor)
        Text("Hello, world!")
        Button("Save Feed") {
        }
        NavigationStack {
            List(dataStore.feedStores) { feedStore in
                NavigationLink(destination: Text(feedStore.feed.feedID)) {
                    FeedCardView(feed: feedStore.feed)
                }
            }
        }
        NewFeedEntryView()
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView()
            .environmentObject(DataStore.sampleDataStore)
    }
}
