//
//  NewFeedEntryView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct NewFeedEntryView: View {
    @State private var newEntry: String = ""
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Enter your new feed message:", text: $newEntry)
                Button(action: {
                    let nextSeq = dataStore.personalFeed.getLastLogEntry().sequenceNumber + 1
                    let newBody = Bodyy(tag: Apps.txt, value: newEntry)
                    let newLogEntry = LogEntry(feedid: dataStore.personalID, sequenceNumber: nextSeq, body: newBody)
                    dataStore.personalFeed.appendLogEntry(log: newLogEntry)
                    newEntry = ""
                }) {
                    Text("Send")
                }
                .task {
                    do {
                        try await dataStore.savePersonalFeed()
                    } catch {
                        // Handle the error
                        print("Error loading data: \(error)")
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
        .padding()
    }
}

struct NewFeedEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewFeedEntryView()
            .environmentObject(DataStore.sampleDataStore)
    }
}
