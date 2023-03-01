//
//  BluetoothService.swift
//  bluetooth
//
//  Created by Yutaro on 2022/11/05.
//

import Foundation
import CoreBluetooth
import Combine

final class BluetoothService: NSObject, CBPeripheralManagerDelegate {
    private (set)var centralManager: CBCentralManager?
    private (set)var peripheralManager: CBPeripheralManager?
    @Published var cbManagerState: CBManagerState?
    @Published var didConnectPeripheral = false
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var command: String = ""
    let LEDServiceUUID = "8c581e7e-b368-11ed-afa1-0242ac120002"
    let LEDCharacteristicUUID = "a6fa1778-b368-11ed-afa1-0242ac120002"
    var LEDCharacteristic: CBCharacteristic?
    var peripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        centralManager?.scanForPeripherals(withServices: nil)
    }
    
    func connect(to peripheral: CBPeripheral) {
        centralManager?.connect(peripheral, options: nil)
    }
    
    func readJoystick() {
        peripheral?.readValue(for: LEDCharacteristic!)
    }
}

extension BluetoothService: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        cbManagerState = central.state
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier } ) {
            discoveredPeripherals.append(peripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.peripheral = peripheral
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        didConnectPeripheral = true
    }
}



extension BluetoothService: CBPeripheralDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let service = peripheral.services?.first {
            print("Searching characteristics")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            if characteristic.uuid == CBUUID(string: LEDCharacteristicUUID) {
                self.LEDCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let decoded = String(data: characteristic.value!, encoding: .utf8)
        command = decoded!
    }
}
