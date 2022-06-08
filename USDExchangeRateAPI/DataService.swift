//
//  DataService.swift
//  USDExchangeRateAPI
//
//  Created by Sy Lee on 2022/06/08.
//

import Foundation
import Combine

class DataService {
    
    @Published var usdModel: ExchangeRateModel? = nil
    
    var usdSubscription: AnyCancellable?
    
    var currentDate = Date()
    
    init() {
        fetchUSD()
    }
    
    private func fetchUSD() {
        guard let url = URL(string: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=HCBiZ4wSwjer7d3VzKzaZQgHTkeCTFs5&searchdate=\(currentDate.asCustomString())&data=AP01") else { return }
       usdSubscription = NetworkingManager.download(url: url)
            .decode(type: [ExchangeRateModel].self, decoder: JSONDecoder())
            .map { exchanges -> ExchangeRateModel? in
                if exchanges.isEmpty {
                    self.currentDate = self.currentDate.addingTimeInterval(-24*60*60)
                    self.fetchUSD()
                }
                let usdExchangeRate = exchanges.first { $0.curUnit == "USD" }
                return usdExchangeRate
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                NetworkingManager.completionHandler(completion: completion)
            } receiveValue: { [weak self] returnedModel in
                self?.usdModel = returnedModel
                self?.usdSubscription?.cancel()
            }
    }
}
