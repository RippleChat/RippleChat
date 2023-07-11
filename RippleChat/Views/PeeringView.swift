//
//  PeeringView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct PeeringView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        Text("Peering View")
        NavigationView {
            List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
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
