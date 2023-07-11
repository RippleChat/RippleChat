//
//  ContentView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 05.07.23.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @State var currentView = 0
    @StateObject var dataStore = DataStore()
    
    var body: some View {
        VStack {
            switch self.currentView {
            case 0:
                PeeringView()
                    .environmentObject(dataStore)
            case 1:
                FeedListView(feeds: [])
                    .environmentObject(dataStore)
            case 2:
                SettingsView()
                    .environmentObject(dataStore)
                    .navigationTitle("Settings")
            default:
                FeedListView(feeds: [])
                    .environmentObject(dataStore)
            }
            HStack {
                Button(action: {
                    self.currentView = 0
                }) {
                    VStack {
                        Label("Discovery", systemImage: "dot.radiowaves.left.and.right")
                    }
                }
                Spacer()
                Button(action: {
                    self.currentView = 1
                }) {
                    VStack {
                        Label("Feeds", systemImage: "person.2")
                    }
                }
                Spacer()
                Button(action: {
                    self.currentView = 2
                }) {
                    VStack {
                        Label("Settings",systemImage: "gear")
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.05)
        }
        .padding()
 
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore())
    }
}


