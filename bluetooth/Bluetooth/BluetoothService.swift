//
//  BluetoothService.swift
//  bluetooth
//
//  Created by Yutaro on 2022/11/05.
//

import Foundation
import CoreBluetooth
import Combine

final class BluetoothService: NSObject {
    private (set)var centralManager: CBCentralManager?
    @Published var cbManagerState: CBManagerState?
    @Published var didConnectPeripheral = false
    @Published var discoveredPeripherals: [CBPeripheral] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        centralManager?.scanForPeripherals(withServices: nil)
    }
    
    func connect(to peripheral: CBPeripheral) {
        centralManager?.connect(peripheral, options: nil)
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
}
