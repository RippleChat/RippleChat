//
//  PeeringView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct PeeringView: View {
    @ObservedObject private var bluetoothController = BluetoothController()
    @ObservedObject private var bluetoothPeripheral = BluetoothPeripheral()
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        Text("Peering View")
        NavigationView {
            List(bluetoothController.peripheralNames, id: \.self) { peripheral in
                Text(peripheral)
            }
            .navigationTitle("Peripherals")
        }
    }
}

struct PeeringView_Previews: PreviewProvider {
    static var previews: some View {
        PeeringView()
    }
}
