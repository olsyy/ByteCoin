//
//  ViewController.swift
//  ByteCoin
//
//  Created by Olesia on 28.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func updateCoin(_ coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.rateString
            self.bitcoinLabel.text = coin.coinName
        }
    }
}
    
    //MARK: - UIPickerViewDelegate
    
    extension ViewController: UIPickerViewDelegate {
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedCurrency = coinManager.currencyArray[row]
            coinManager.getCoinPrice(for: selectedCurrency)
        }
    }
    
    //MARK: - UIPickerViewDataSource
    
    extension ViewController: UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return coinManager.currencyArray.count
        }
    }
