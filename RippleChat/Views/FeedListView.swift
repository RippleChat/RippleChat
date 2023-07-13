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
        NavigationStack {
            Form {
                Section(header: Text("Your own Feed:")) {
                    NavigationLink(destination: FeedDetailView(feed: dataStore.personalFeed)) {
                        FeedCardView(feed: dataStore.personalFeed)
                    }
                }
                Section(header: Text("Feeds of your Firends")) {
                    List(dataStore.feedStores) { feedStore in
                        NavigationLink(destination: FeedDetailView(feed: feedStore.feed)) {
                            FeedCardView(feed: feedStore.feed)
                        }
                    }
                }
            }
            NewFeedEntryView()
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView()
            .environmentObject(DataStore.sampleDataStore)
    }
}
