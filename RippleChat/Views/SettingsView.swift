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
        
     
            List {
                HStack {
                    Spacer()
                    Button("Edit") {
                        isPresentingEditView = true
                    }
                }
                Section(header: Text("Personal Feed ID")) {
                    Label(dataStore.personalID, systemImage: "person.crop.circle")
                }
                Section(header: Text("Friends")) {
                    ForEach(dataStore.friends) { friend in
                        Label(friend, systemImage: "person")
                    }
                }
            }
            .navigationTitle("Settings")
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
                                }
                            }
                        }
                }
        }
    }
        
}


struct SettingsView_Previews: PreviewProvider {
    static var friends = [
        "BOS",
        "ALI",
        "CYN"
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

