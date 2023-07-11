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
                ForEach(dataStore.friends) { friend in
                    Label(friend, systemImage: "person")
                }
                .onDelete {indices in
                    dataStore.friends.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Feed", text: $newFeedID)
                    Button(action: {
                        withAnimation {
                            let feedid = newFeedID
                            dataStore.friends.append(feedid)
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
