//
//  ContentVM.swift
//  USDExchangeRateAPI
//
//  Created by Sy Lee on 2022/06/08.
//

import Foundation
import Combine

class ContentVM: ObservableObject {
    
    @Published var usdExchangeRate: ExchangeRateModel? = nil
    
    private var subscription = Set<AnyCancellable>()
    private let dataService = DataService()
    
    init() {
        subscribeService()
    }
    
    private func subscribeService() {
        dataService.$usdModel
            .sink { [weak self] usdModel in
                self?.usdExchangeRate = usdModel
            }
            .store(in: &subscription)
    }
}
