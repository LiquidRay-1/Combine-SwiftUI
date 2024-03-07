//
//  ContentView.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import SwiftUI

extension Color {
    static let bitcoinGreen: Color = Color.green.opacity(0.9)
}

struct BitcoinPriceView: View {
    
    @ObservedObject var viewModel: BitcoinPriceViewModel
    
    //Moneda seleccionada
    @State private var selectedCurrency: Currency = .eur
    
    var body: some View {
        VStack (spacing: 0) {
            Text("Actualizado el \(viewModel.lastUpdated)")
                .padding(.vertical)
                .foregroundStyle(Color.bitcoinGreen)
            TabView(selection: $selectedCurrency,
                    content:  {
                
                ForEach(viewModel.priceDetails.indices, id: \.self){ index in
                    let priceDetails = viewModel.priceDetails[index]
                    PriceDetailsView(priceDetails: priceDetails)
                        .tag(priceDetails.currency)
                }
            })
            .tabViewStyle(PageTabViewStyle())
            
            VStack(spacing: 0){
                HStack(alignment: .center){
                    //Cambiar moneda
                    Picker(selection: $selectedCurrency, content: {
                        Text("\(Currency.usd.icon) \(Currency.usd.code)").tag(Currency.usd)
                        Text("\(Currency.gbp.icon) \(Currency.gbp.code)").tag(Currency.gbp)
                        Text("\(Currency.eur.icon) \(Currency.eur.code)").tag(Currency.eur)
                    }, label: {Text("Currency")})
                    .padding(.leading)
                    .tint(Color.bitcoinGreen)
                    Spacer()
                    Button(action: viewModel.onAppear){
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                    }
                    .padding(.trailing)
                }
                .tint(Color.bitcoinGreen)
                .padding(.top)
                Link("Powered by Coindek", destination: URL(string: "https://coindesk.com/price/bitcoin")!
                )
                .font(.caption)
                .foregroundStyle(Color.bitcoinGreen)
            }
            
        }
        .onAppear(perform: viewModel.onAppear)
        .pickerStyle(MenuPickerStyle())
    }
}

#Preview {
    BitcoinPriceView(viewModel: BitcoinPriceViewModel())
}
