
import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func updateCoin( _ coin: CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://api.apilayer.com/fixer/convert?"
    let apiKey = "dp849hjBG4YGjyyOSCIlEO5QPVOkhfXC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)to=\(currency)&from=BTC&amount=1&apikey=\(apiKey)"
        performRequest(url: url)
    }
    
    func performRequest(url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let price = self.parseJSON(safeData) {
                        delegate?.updateCoin(price)
                        }
                }
            }
            task.resume()
        }
    }
        
        func parseJSON(_ data: Data) -> CoinModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CoinData.self, from: data)
                let rate = decodedData.result
                let name = decodedData.query.to
                let result = CoinModel(rate: rate, coinName: name)
                return result
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }

            
