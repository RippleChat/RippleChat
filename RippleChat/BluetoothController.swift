//
//  BluetoothController.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 09.07.23.
//

import SwiftUI
import CoreBluetooth

class BluetoothController: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    
    var writeCharacteristics: [CBCharacteristic] = []
    
    let BLE_SERVICE_UUID = CBUUID(string: "6e400001-7646-4b5b-9a50-71becce51558")
    let BLE_CHARACTERISTIC_UUID_RX = CBUUID(string: "6e400002-7646-4b5b-9a50-71becce51558")
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BluetoothController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: [BLE_SERVICE_UUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            centralManager?.connect(peripheral)
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            print("No characteristics found for service \(service.uuid)")
            return
        }

        for characteristic in characteristics {
            if characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse) {
                // This characteristic supports writing
                writeCharacteristics.append(characteristic)
            }
        }
    }

    func writeToCharacteristics(message: String) {
        guard let messageData = message.data(using: .utf8) else {
            print("Could not convert message to data.")
            return
        }

        // Go through 
        for characteristic in writeCharacteristics {
            // Go through connected peripherals and write to their characteristic
            for peripheral in peripherals {
                peripheral.writeValue(messageData, for: characteristic, type: .withResponse)
            }
        }
    }
}
