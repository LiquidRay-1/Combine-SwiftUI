//
//  NetworkManager.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import Foundation

class NetworkManager {
    func descargarDatosDeAPI(apiResponse: @escaping(APIResponse) -> ()){
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20
        
        let session = URLSession.shared
        session.dataTask(with: request){ (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    DispatchQueue.main.async {
                        print("Error en la petición")
                    }
                    return
                }
                guard let data = data else {return}
                if let decodeData = try? JSONDecoder().decode(APIResponse.self, from: data){
                    print("Datos descargados correctamente")
                    DispatchQueue.main.async {
                        apiResponse(decodeData)
                    }
                } else {
                    print("Se ha producido un error al decodificar el json: \(data)")
                }
            }
        }.resume()
    }
}
