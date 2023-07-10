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
    //@Binding var currentView: CurrentView
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
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
        Spacer()
        NewFeedEntryView()
//        NavigationView {
//            List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
//                Text(peripheral)
//            }
//            .navigationTitle("Peripherals")
//        }
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    public static var cv = CurrentView.feeds
    static var previews: some View {
        ContentView()
    }
}


