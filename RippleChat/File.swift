//
//  File.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 13.07.23.
//

func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if let error = error {
        print("Error discovering services: \(error.localizedDescription)")
        return
    }

    for service in peripheral.services ?? [] {
        if service.uuid == CBUUID(string: "YourServiceUUIDHere") {
            peripheral.discoverCharacteristics([CBUUID(string: "YourCharacteristicUUIDHere")], for: service)
        }
    }
}

func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    if let error = error {
        print("Error discovering characteristics: \(error.localizedDescription)")
        return
    }

    for characteristic in service.characteristics ?? [] {
        if characteristic.uuid == CBUUID(string: "YourCharacteristicUUIDHere") {
            // You've found your characteristic!
        }
    }
}
