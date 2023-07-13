//
//  PeeringView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct PeeringView: View {
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var btController: BluetoothController
    @EnvironmentObject var btPeripheral: BluetoothPeripheral
    
    var body: some View {
        NavigationStack {
            List(btController.peripheralNames, id: \.self) { peripheral in
                Text(peripheral)
            }
            .navigationTitle("Peering")
            .navigationViewStyle(StackNavigationViewStyle())
            Button(action: {
                do {
                    let WANT_msg = WantMessage(friends: dataStore.friends)
                    let encoded_msg = try JSONEncoder().encode(WANT_msg)
                    

                } catch {
                    fatalError(error.localizedDescription)
                }

            }) {
                
            }
            .padding()
        }
    }
}

struct PeeringView_Previews: PreviewProvider {
    static var previews: some View {
        PeeringView()
            .environmentObject(BluetoothPeripheral())
            .environmentObject(BluetoothController())
    }
}

struct WantMessage: Codable {
    var commmand = "WANT"
    var friends = [String:Int]()
    
}
