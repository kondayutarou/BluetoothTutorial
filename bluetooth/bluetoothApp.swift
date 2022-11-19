//
//  bluetoothApp.swift
//  bluetooth
//
//  Created by Yutaro on 2022/11/05.
//

import SwiftUI

@main
struct bluetoothApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}

let bluetoothService = BluetoothService()
