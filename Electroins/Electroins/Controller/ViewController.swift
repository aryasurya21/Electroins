//
//  ViewController.swift
//  Electroins
//
//  Created by IT Division on 05/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension ViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let targetCurrency = coinManager.currencyArray[row]
        coinManager.fetchBitCoinData(TargetCurrency: targetCurrency)
    }
}

extension ViewController : CoinManagerDelegate {
    func didUpdateCoinData(_ coinData: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinData.asset_id_quote
            self.bitcoinLabel.text = String(format:"%.2f", coinData.rate)
        }
    }
        
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
