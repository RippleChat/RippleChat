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
                Button(action: {}) {
                    Text("Send")
                }
            }
            Text("New entry: \(newEntry)")
        }
        .padding()
    }
}

struct NewFeedEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewFeedEntryView()
    }
}
