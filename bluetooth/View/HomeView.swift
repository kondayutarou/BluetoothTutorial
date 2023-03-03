//
//  ContentView.swift
//  bluetooth
//
//  Created by Yutaro on 2022/11/05.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 40.0) {
                Button(action: viewModel.onTapStartScanning) {
                    Text("Scan for peripherals")
                }
                
                Button(action: viewModel.onTapStopScanning) {
                    Text("Stop scanning")
                }

                ForEach(viewModel.discoveredPeripherals, id: \.identifier) { peripheral in
                    HStack {
                        Text(peripheral.name ?? peripheral.identifier.uuidString)
                        Button("Connect") {
                            viewModel.onTapConnect(peripheral)
                        }
                    }
                }
                
                DesignViewWrapper()
            }
        }
        .padding(.vertical, 40.0)
        .popover(isPresented: $viewModel.didConnectPeripheral) {
            Text("Connected to peripheral")
            Text("Command: \(viewModel.command)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
