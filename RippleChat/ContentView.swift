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
                Spacer()
                Button(action: {
                    self.currentView = 0
                }) {
                    VStack {
                        Image(systemName: "dot.radiowaves.left.and.right")
                        Text("Discovery")
                    }
                }
                Spacer()
                Button(action: {
                    self.currentView = 1
                }) {
                    VStack {
                        Image(systemName: "person.2")
                        Text("Feeds")
                    }
                }
                Spacer()
                Button(action: {
                    self.currentView = 2
                }) {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height * 0.05)
        }
 
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore())
    }
}


