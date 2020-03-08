//
//  CoinManager'.swift
//  Electroins
//
//  Created by IT Division on 08/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinData(_ coinData : CoinModel)
    func didFailWithError(_ error : Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "BD10E672-B2F4-4F6F-A443-576A31716CA6"
    let currencyArray = [
        "AUD","BRL","CAD","CNY","EUR","GBP",
        "HKD","IDR","ILS","INR","JPY","MXN",
        "NOK","NZD","PLN","RON","RUB","SEK",
        "SGD","USD","ZAR"
    ]
    
    var delegate : CoinManagerDelegate?
    
    func fetchBitCoinData(TargetCurrency: String){
        let endPoint = "\(baseURL)/\(TargetCurrency)?apikey=\(apiKey)"
        self.performRequest(with: endPoint)
    }
    
    func performRequest(with urlString: String){
        if let myURL = URL(string: urlString) {
            let browser = URLSession(configuration: .default)
            let task = browser.dataTask(with: myURL){(data, response, error) in
                if(error != nil){
                    self.delegate?.didFailWithError(error!)
                }
                if let safeData = data {
                    if let convertedData = self.parseJson(targetCurrency: safeData) {
                        self.delegate?.didUpdateCoinData(convertedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(targetCurrency : Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinModel.self, from: targetCurrency)
            let base = decodedData.asset_id_base
            let target = decodedData.asset_id_quote
            let rate = decodedData.rate
            let time = decodedData.time
            let returnedData = CoinModel(time: time, asset_id_base: base, asset_id_quote: target, rate: rate)
            return returnedData
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}
