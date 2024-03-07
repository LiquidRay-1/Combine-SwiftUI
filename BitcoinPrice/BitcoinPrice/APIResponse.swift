//
//  APIResponse.swift
//  BitcoinPrice
//
//  Created by dam2 on 7/3/24.
//

import Foundation

struct APIResponse: Decodable {
    let time: APITime
    let bpi: APIBitcoinPriceIndex
}

struct APITime: Decodable {
    let updated: String
}

struct APIBitcoinPriceIndex: Decodable {
    let USD: APIPriceData
    let GBP: APIPriceData
    let EUR: APIPriceData
}

struct APIPriceData: Decodable {
    let rate: String
}
