//
//  SettingsEditView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI

struct SettingsEditView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var newFeedID = ""
    
    var body: some View {
        Form {
            Section(header: Text("Personal Feed ID")) {
                //Label(dataStore.personalID, systemImage: "person.crop.circle")
                HStack {
                    TextField(dataStore.personalID, text: $dataStore.personalID) 

                }
            }
            Section(header: Text("Friends")) {
                ForEach(dataStore.friends.keys.sorted(), id: \.self) { friend in
                    if let seq = dataStore.friends[friend] {
                        Label("\(friend) - SEQ: \(seq)", systemImage: "person")
                    }
                }
                .onDelete { indexSet in do {
                    indexSet.forEach { index in
                        let key = dataStore.friends.keys.sorted()[index]
                        dataStore.friends.removeValue(forKey: key)
                    }
                    dataStore.feedStores.remove(atOffsets: indexSet)
                    
                }
                }
                HStack {
                    TextField("New Feed", text: $newFeedID)
                    Button(action: {
                        let newFeed = Feed(feedID: newFeedID)
                        let newFeedStore = FeedStore(feed: newFeed)
                        dataStore.feedStores.append(newFeedStore)
                        withAnimation {
                            dataStore.friends[newFeedID] = 0
                            newFeedID = ""
                        }
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newFeedID.isEmpty)
                }
            }
        }
    }
}

struct SettingsEditView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsEditView()
            .environmentObject(DataStore())
    }
}
