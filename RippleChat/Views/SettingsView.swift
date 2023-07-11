//
//  SettingsView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI

struct SettingsView: View {
    @State private var newEntry: String = ""
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        Section(header: Text("Personal Feed ID")) {
            Text("Your FeedID is: \(dataStore.personalID)")
        }
        Section(header: Text("Friends")) {

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(DataStore(personalID: "BOB"))
    }
}
