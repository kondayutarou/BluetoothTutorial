//
//  HomeViewModel.swift
//  bluetooth
//
//  Created by Yutaro on 2022/11/05.
//

import Foundation
import Combine
import SwiftUI
import CoreBluetooth

final class HomeViewModel: NSObject, ObservableObject {
    private (set)var cancellableSet: Set<AnyCancellable> = []
    private (set)var onTapStartScanning: (() -> Void)!
    private (set)var onTapStopScanning: (() -> Void)!
    private (set)var onTapConnect: ((CBPeripheral) -> Void)!
    @Published var didConnectPeripheral = false
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var lightLED = false
    @Published var command: String = ""
    
    override init() {
        super.init()
    
        onTapStartScanning = {
            bluetoothService.startScan()
        }
        
        onTapStopScanning = {
            bluetoothService.centralManager?.stopScan()
        }

        onTapConnect = { peripheral in
            bluetoothService.connect(to: peripheral)
        }
        
        $lightLED
            .sink { shouldLight in
                bluetoothService.readJoystick()
            }
            .store(in: &cancellableSet)

        bluetoothService.$cbManagerState
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .poweredOn:
                    print("power is on")
                case .poweredOff:
                    print("power is off")
                default:
                    break
                }
            }
            .store(in: &cancellableSet)
        
        bluetoothService.$didConnectPeripheral
            .receive(on: DispatchQueue.main)
            .sink { [weak self] connected in
                self?.didConnectPeripheral = connected
            }
            .store(in: &cancellableSet)
        
        bluetoothService.$discoveredPeripherals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] peripherals in
                self?.discoveredPeripherals = peripherals
            }
            .store(in: &cancellableSet)
        
        bluetoothService.$command
            .removeDuplicates()
            .assign(to: &$command)
    }
    
    deinit {
        cancellableSet.removeAll()
    }
}
