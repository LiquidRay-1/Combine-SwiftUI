//
//  BitcoinPriceViewModel.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import Combine

class BitcoinPriceViewModel: ObservableObject {
    
    //Fecha la ultima actualizacion
    @Published public private(set) var lastUpdated: String = ""
    @Published public private(set) var priceDetails: [PriceDetails] = Currency.allCases.map {
        //Para cada caso de Currency creamos un objeto PriceDetails con ese currency
        PriceDetails(currency: $0)
    }
    
    //Crear una suscripción a nuestro Publisher
    private var suscripcion: AnyCancellable? //Suscripción cancelable
    
    public func onAppearCombine(){
        //Obtener los datos de la API
        //Inicializar la suscripción
        suscripcion = CoindeskAPIService.shared.fetchBitcoinPrice()
            .sink(receiveCompletion: { completion in
                //Sólo se puede devolver .failure o .finish
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("succes")
                }
            }, receiveValue: { [weak self] value in
                //Actualizar las instancia del Viewmodel
                guard let self = self else { return }
                //Actualizamos las propiedades publicadas
                self.lastUpdated = value.time.updated
                self.priceDetails = [
                    PriceDetails(currency: .usd, rate: value.bpi.USD.rate),
                    PriceDetails(currency: .gbp, rate: value.bpi.GBP.rate),
                    PriceDetails(currency: .eur, rate: value.bpi.EUR.rate)
                ]
            })
    }
    
    //Utilizando NetworkManager
    public func onAppear(){
        let networkManager = NetworkManager()
        networkManager.descargarDatosDeAPI(){ (apiResponse) in
            self.lastUpdated = apiResponse.time.updated
            self.priceDetails = [
                PriceDetails(currency: .usd, rate: apiResponse.bpi.USD.rate),
                PriceDetails(currency: .gbp, rate: apiResponse.bpi.GBP.rate),
                PriceDetails(currency: .eur, rate: apiResponse.bpi.EUR.rate)
            ]
        }
    }
}
