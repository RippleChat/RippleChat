//
//  BTPeripheral.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI
import CoreBluetooth

class BluetoothPeripheral: NSObject, ObservableObject {
    
    @Published var incomingMsg: String = ""
    @Published var wantVector: WantMessage = WantMessage()
    private var peripheralManager: CBPeripheralManager?
    
    let BLE_SERVICE_UUID = CBUUID(string: "6e400001-7646-4b5b-9a50-71becce51558")
    let BLE_CHARACTERISTIC_UUID_RX = CBUUID(string: "6e400002-7646-4b5b-9a50-71becce51558")
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: .main)
    }
}

extension BluetoothPeripheral: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown:
            print("BT Device is UNKNOWN")
        case .unsupported:
            print("BT Device is UNSUPPORTED")
        case .unauthorized:
            print("BT Device is UNAUTHORIZED")
        case .resetting:
            print("BT Device is RESETTING")
        case .poweredOff:
            print("BT Device is POWERED OFF")
        case .poweredOn:
            print("BT Device is POWERED ON")
            addBTService()
        @unknown default:
            fatalError()
        }
    }
    
    func addBTService() {
        let myCharacteristic = CBMutableCharacteristic(type: BLE_CHARACTERISTIC_UUID_RX, properties: [.read, .write, .notify, .writeWithoutResponse], value: nil, permissions: [.readable, .writeable])
        let myService = CBMutableService(type: BLE_SERVICE_UUID, primary: true)
        myService.characteristics = [myCharacteristic]
        peripheralManager!.add(myService)
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        peripheralManager!.startAdvertising([CBAdvertisementDataLocalNameKey : "RippleChat", CBAdvertisementDataServiceUUIDsKey: [BLE_SERVICE_UUID]])
        print("Started Advertising")
        if(peripheralManager?.delegate == nil) {
            print("peripheral is nil")
        } else {
            print("peripheral is not nil")
        }
    }
    
    func discoverServices(_ serviceUUIDs: [CBUUID]?) {
        print("test Peripheral")
        print("Discovering services... \(String(describing: serviceUUIDs))")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Discovering Services Peripheral")
//            print("*******************************************************")
//
//            if ((error) != nil) {
//                print("Error discovering services: \(error!.localizedDescription)")
//                return
//            }
//            guard let services = peripheral.services else {
//                return
//            }
//            //We need to discover the all characteristic
//            for service in services {
//                peripheral.discoverCharacteristics(nil, for: service)
//            }
//            print("Discovered Services: \(services)")
        }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if let value = request.value {
                // Handle the received data
                let receivedData = Data(value)
                
                print(receivedData)
                
                // Decode the received JSON string into your data structure
                let decoder = JSONDecoder()
                do {
                    let receivedObject = try decoder.decode(WantMessage.self, from: receivedData)
                    // Use the received object to update your app state as needed
                    print("Received Write")
                    self.incomingMsg = ""
                    self.incomingMsg = receivedObject.printMsg()
                    self.wantVector = receivedObject
                    print(receivedObject.printMsg())
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
                
                // If you want to write back to the central
//                if let central = request.central {
//                    let dataToWrite = // some data you want to send back
//                    let writeType: CBCharacteristicWriteType = // choose .withResponse or .withoutResponse
//                    central.writeValue(dataToWrite, for: request.characteristic, type: writeType)
//                }
                
            }
            
            // Respond to the write request
            peripheral.respond(to: request, withResult: .success)
        }
    }

}
