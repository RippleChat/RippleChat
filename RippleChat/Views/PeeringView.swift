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
            Text("Incoming msg: \(btPeripheral.incomingMsg)")
            Button(action: {
                do {
                    let WANT_msg = WantMessage(friends: dataStore.friends)
                    let encoded_msg = try JSONEncoder().encode(WANT_msg)
                    btController.writeToCharacteristics(message: String(data: encoded_msg, encoding: .utf8)!)
                    //btController.writeToCharacteristics(message: "Test")
                    print("Pressed Button")
                } catch {
                    fatalError(error.localizedDescription)
                }
            }) {
                Text("Send WANT-Vector")
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
    var command = "WANT"
    var friends = [String:Int]()
    
    func printMsg() -> String {
        return ("\(command) : \(friends.description)")
    }
}
