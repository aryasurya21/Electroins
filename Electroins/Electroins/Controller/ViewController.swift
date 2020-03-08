//
//  ViewController.swift
//  Electroins
//
//  Created by IT Division on 05/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
 
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

    func didUpdateCoinData(_ coinData: CoinModel) {
        <#code#>
    }
    
    func didFailWithError(_ error: Error) {
        <#code#>
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
     }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        
        coinManager.fetchBitCoinData(TargetCurrency: coinManager.currencyArray[row])
    }
}

