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
    
    func sendWantVector(data: Data) {
        for peripheral in peripherals {
            //peripheral.writeValue(data, for: peripheral., type: .withoutResponse)
        }
    }
}
