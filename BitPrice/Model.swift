//
//  Model.swift
//  BitPrice
//
//  Created by Maxwell Silva on 03/02/25.
//

struct BitcoinPrice: Codable {
    let buy: Double
}

struct TickerResponse: Codable {
    let BRL: BitcoinPrice
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}
