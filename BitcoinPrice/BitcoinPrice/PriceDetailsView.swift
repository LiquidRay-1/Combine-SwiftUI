//
//  PriceDetailsView.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import SwiftUI

struct PriceDetailsView: View {
    
    let priceDetails: PriceDetails
    
    var body: some View {
        ZStack {
            Color.bitcoinGreen
            VStack {
                Text(priceDetails.currency.icon)
                    .font(.largeTitle)
                Text("1 Bitcoin = ")
                    .bold()
                    .font(.title2)
                Text("\(priceDetails.rate) \(priceDetails.currency.code)")
                    .bold()
                    .font(.largeTitle)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    PriceDetailsView(priceDetails:  PriceDetails(currency: .eur))
}
