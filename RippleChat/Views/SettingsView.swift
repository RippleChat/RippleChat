//
//  SettingsView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var dataStore: DataStore
    
    @State private var isPresentingEditView = false
    
    
    var body: some View {
        
        NavigationStack {
            List {
                Section(header: Text("Personal Feed ID")) {
                    Label(dataStore.personalID, systemImage: "person.crop.circle")
                }
                Section(header: Text("Friends")) {
                    ForEach(dataStore.friends.keys.sorted(), id: \.self) { friend in
                        if let seq = dataStore.friends[friend] {
                            Label("\(friend) - SEQ: \(seq)", systemImage: "person")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationStack {
                    SettingsEditView()
                        .navigationTitle("Settings")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    dataStore.personalFeed = Feed(feedID: dataStore.personalID)
                                }
                            }
                        }
                }
        }
        }
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    static var friends = [
        "BOS":1,
        "ALI":2,
        "CYN":3
    ]
    static var previews: some View {
        SettingsView()
            .environmentObject(DataStore(personalID: "BOB", friends: friends))
            .navigationTitle("Settings")
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

