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
            List {
                ForEach(btPeripheral.wantVector.friends.keys.sorted(), id: \.self) { friend in
                    Text("Feed: \(friend.description), SEQ: \(btPeripheral.wantVector.friends[friend] ?? -1)")
                }
            }
            Text("Incoming msg: \(btPeripheral.incomingMsg)")
                .onChange(of: btPeripheral.incomingMsg) { newValue in
                    compareWithSavedFeeds(newVector: btPeripheral.wantVector)
                }
            Button(action: {
                do {
                    var combinedDict = dataStore.friends
                    combinedDict[dataStore.personalFeed.feedID] = dataStore.personalFeed.feed.count
                    let WANT_msg = WantMessage(friends: combinedDict)
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
    
    func compareWithSavedFeeds(newVector: WantMessage) {
        print("comparing with saved Feeds...")
        for friend in newVector.friends.keys.sorted() {
            if(dataStore.friends.keys.contains(friend.description)) {
                print("Found friend \(friend.description) in own Feeds!")
                var missingFeedEntries: Int = -1
                if let ownCount = dataStore.friends[friend] {
                    missingFeedEntries = newVector.friends[friend]! - ownCount
                }
                print("You are \(missingFeedEntries) behind on the feed of \(friend.description)")
            }
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
        return ("{\(command) : \(friends.description)}")
    }
}
