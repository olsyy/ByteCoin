//
//  CoinData.swift
//  ByteCoin
//
//  Created by Olesia on 06.05.2023.
//

import Foundation

struct CoinData: Decodable {
    let result: Double
    let query: Query
}

struct Query: Decodable {
    let from: String
    let to: String
    let amount: Int
}
