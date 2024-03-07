//
//  CoindeskAPIService.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import Foundation
import Combine

struct CoindeskAPIService {
    //Instancia compartida del API service
    public static let shared: CoindeskAPIService = CoindeskAPIService()
    
    public func fetchBitcoinPrice() -> AnyPublisher<APIResponse, Error> {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            let error = URLError(.badURL)
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response in
                //Comprobar que tiene el formato correcto
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(URLError.unknown)
                }
                //Comprobar el status code
                guard httpResponse.statusCode == 200 else {
                    let code = URLError.Code(rawValue: httpResponse.statusCode)
                    throw URLError(code)
                }
                //Si todo ha ido bien en la petición, devolvemos data
                return data
            })
            .decode(type: APIResponse.self, decoder: JSONDecoder()) // Decodificamos los datos del json al tipo
            .receive(on: DispatchQueue.main) //Recibimos los datos del hilo principal
            .eraseToAnyPublisher() //Envolvemos el URLSession dataTaskPublisher en un AnyPublisher
    }
}
