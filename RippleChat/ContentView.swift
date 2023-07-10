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
                        try await store.save(feed: Feed.sampleFeed)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
