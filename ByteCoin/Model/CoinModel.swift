//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Olesia on 06.05.2023.
//

import Foundation

struct CoinModel {
    let rate: Double
    let coinName: String
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
