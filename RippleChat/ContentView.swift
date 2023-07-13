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
    @EnvironmentObject var dataStore: DataStore
    @StateObject private var bluetoothController = BluetoothController()
    @StateObject private var bluetoothPeripheral = BluetoothPeripheral()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        VStack {
            switch self.currentView {
            case 0:
                PeeringView()
                    .environmentObject(dataStore)
                    .environmentObject(bluetoothController)
                    .environmentObject(bluetoothPeripheral)
                    .navigationTitle("Peering")
            case 1:
                FeedListView()
                    .environmentObject(dataStore)
                    .environmentObject(bluetoothController)
                    .environmentObject(bluetoothPeripheral)
                    .navigationTitle("Feeds")
            case 2:
                SettingsView()
                    .environmentObject(dataStore)
                    .environmentObject(bluetoothController)
                    .environmentObject(bluetoothPeripheral)
                    .navigationTitle("Settings")
            default:
                FeedListView()
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
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(saveAction: {})
            .environmentObject(DataStore())
    }
}


