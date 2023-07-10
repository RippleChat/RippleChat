//
//  ContentView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 05.07.23.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    @StateObject private var store = FeedStore(feed: Feed.sampleFeed)
    private var feedStores = [FeedStore(feed: Feed.sampleFeed), FeedStore(feed: Feed.sampleFeed2)]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Spacer()
            Button("Save Feed") {
                Task {
                    do {
                        // try await store.save(feed: Feed.sampleFeed)
                        for feed in feedStores {
                            try await feed.save(feed: feed.feed)
                        }
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
        .padding()
        NavigationView {
            List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
                Text(peripheral)
            }
            .navigationTitle("Peripherals")
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Peers") {}
                
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum CurrentView {
    case peers
    case feeds
    case friends
    case settings
}
