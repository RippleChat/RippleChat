//
//  BTPeripheral.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI
import CoreBluetooth

class BluetoothPeripheral: NSObject, ObservableObject {
    
    private var peripheralManager: CBPeripheralManager?
    
    let BLE_SERVICE_UUID = CBUUID(string: "6e400001-7646-4b5b-9a50-71becce51558")
    let BLE_CHARACTERISTIC_UUID_RX = CBUUID(string: "6e400002-7646-4b5b-9a50-71becce51558")
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: .main)
    }
}

// TODO: Change variable names, etc...

extension BluetoothPeripheral: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .unknown:
            print("Bluetooth Device is UNKNOWN")
        case .unsupported:
            print("Bluetooth Device is UNSUPPORTED")
        case .unauthorized:
            print("Bluetooth Device is UNAUTHORIZED")
        case .resetting:
            print("Bluetooth Device is RESETTING")
        case .poweredOff:
            print("Bluetooth Device is POWERED OFF")
        case .poweredOn:
            print("Bluetooth Device is POWERED ON")
            addServices()
        @unknown default:
            fatalError()
        }
    }
    
    func addServices() {
        
        let myCharacteristic = CBMutableCharacteristic(type: BLE_CHARACTERISTIC_UUID_RX, properties: [.read, .write, .notify], value: nil, permissions: [.readable])
       
        // 2. Create instance of CBMutableService
        let myService = CBMutableService(type: BLE_SERVICE_UUID, primary: true)
        
        // 3. Add characteristics to the service
        myService.characteristics = [myCharacteristic]
        
        // 4. Add service to peripheralManager
        peripheralManager!.add(myService)
        
        // 5. Start advertising
        peripheralManager!.startAdvertising([CBAdvertisementDataLocalNameKey : "RippleChat", CBAdvertisementDataServiceUUIDsKey : BLE_SERVICE_UUID])
        print("Started Advertising")
       
    }
    
//    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
//        
//        messageLabel.text = "Data getting Read"
//        readValueLabel.text = value
//
//        // Perform your additional operations here
//
//    }
//
//    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
//
//        messageLabel.text = "Writing Data"
//
//        if let value = requests.first?.value {
//           writeValueLabel.text = value.hexEncodedString()
//            //Perform here your additional operations on the data you get
//        }
//    }
}
