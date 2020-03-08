//
//  CoinModel.swift
//  Electroins
//
//  Created by IT Division on 08/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct CoinModel : Decodable {
    let time : String
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
    
    init(time: String, asset_id_base : String, asset_id_quote : String, rate : Double) {
        self.time = time
        self.asset_id_quote = asset_id_quote
        self.asset_id_base = asset_id_base
        self.rate = rate
    }
}
