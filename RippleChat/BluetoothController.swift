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
    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//    }
}

extension BluetoothController: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Device is powered on...")
            self.centralManager?.scanForPeripherals(withServices: [BLE_SERVICE_UUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripheral.delegate = self
            centralManager!.connect(peripheral)
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([BLE_SERVICE_UUID])
        print("Connected to device \(String(describing: peripheral.name))")
        if(centralManager?.delegate == nil) {
            print("central is nil")
        } else {
            print("central is not nil")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        // Not implemented yet
    }
    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        print("Discovering services...")
//        peripheral.discoverCharacteristics(BLE_CHARACTERISTIC_UUID_RX)
//    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            print("*******************************************************")

            if ((error) != nil) {
                print("Error discovering services: \(error!.localizedDescription)")
                return
            }
            guard let services = peripheral.services else {
                return
            }
            //We need to discover the all characteristic
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
            print("Discovered Services: \(services)")
        }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            print("No characteristics found for service \(service.uuid)")
            return
        }

        for characteristic in characteristics {
            if characteristic.uuid.isEqual(BLE_CHARACTERISTIC_UUID_RX) {
                self.writeCharacteristics.append(characteristic)
                peripheral.setNotifyValue(true, for: characteristic)
                peripheral.readValue(for: characteristic)
                print("Characteristic: \(characteristic.uuid)")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("updating characteristic value...")
        print(characteristic.value ?? "Characteristic is nil")
    }

    func writeToCharacteristics(message: String) {
        guard let messageData = message.data(using: .utf8) else {
            print("Could not convert message to data.")
            return
        }

        print("Writing to Characteristic...")
        // Go through 
        for characteristic in writeCharacteristics {
            // Go through connected peripherals and write to their characteristic
            for peripheral in peripherals {
                peripheral.writeValue(messageData, for: characteristic, type: .withoutResponse)
            }
        }
    }
}
