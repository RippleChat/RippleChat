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
        let myCharacteristic = CBMutableCharacteristic(type: BLE_CHARACTERISTIC_UUID_RX, properties: [.read, .write, .notify], value: nil, permissions: [.readable, .writeable])
        let myService = CBMutableService(type: BLE_SERVICE_UUID, primary: true)
        myService.characteristics = [myCharacteristic]
        peripheralManager!.add(myService)
        peripheralManager!.startAdvertising([CBAdvertisementDataLocalNameKey : "RippleChat", CBAdvertisementDataServiceUUIDsKey: [BLE_SERVICE_UUID]])
        print("Started Advertising")
       
    }
}
