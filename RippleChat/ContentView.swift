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
    
    
    var body: some View {
        VStack {
            switch self.currentView {
            case 0: PeeringView()
            case 1: FeedListView(feeds: [])
            case 2: SettingsView()
            default:
                FeedListView(feeds: [])
            }
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    self.currentView = 0
                }) {
                    VStack {
                        Label("Discovery", systemImage: "dot.radiowaves.left.and.right")
                        Text("Discovery")
                    }
                }
                Spacer()
                Button(action: {
                    self.currentView = 1
                }) {
                    VStack {
                        Label("Feeds", systemImage: "person.2")
                        Text("Feeds")
                    }
                }
                Spacer()
                Button(action: {
                    self.currentView = 2
                }) {
                    VStack {
                        Label("Settings", systemImage: "gear")
                        Text("Settings")
                    }
                }
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


