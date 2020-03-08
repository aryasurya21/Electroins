//
//  CoinManager'.swift
//  Electroins
//
//  Created by IT Division on 08/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "BD10E672-B2F4-4F6F-A443-576A31716CA6"
    let currencyArray = [
        "AUD","BRL","CAD","CNY","EUR","GBP",
        "HKD","IDR","ILS","INR","JPY","MXN",
        "NOK","NZD","PLN","RON","RUB","SEK",
        "SGD","USD","ZAR"
    ]
    
    func fetchBitCoinData(TargetCurrency: String){
        let endPoint = "\(baseURL)/\(TargetCurrency)?apikey=\(apiKey)"
        self.performRequest(with: endPoint)
    }
    func performRequest(with urlString: String){
        if let myURL = URL(string: urlString) {
            let browser = URLSession(configuration: .default)
            let task = browser.dataTask(with: myURL){(data, response, error) in
                if(error != nil){
                    print(error!)
                }
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8))
                }
            }
            task.resume()
        }
    }
}
