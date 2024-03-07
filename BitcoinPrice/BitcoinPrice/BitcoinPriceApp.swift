//
//  BitcoinPriceApp.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import SwiftUI

@main
struct BitcoinPriceApp: App {
    var body: some Scene {
        WindowGroup {
            BitcoinPriceView(viewModel: BitcoinPriceViewModel())
        }
    }
}
