//
//  Date.swift
//  USDExchangeRateAPI
//
//  Created by Sy Lee on 2022/06/08.
//

import Foundation

extension Date {
    private var customDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter
    }
    func asCustomString() -> String {
        return customDateFormatter.string(from: self)
    }
}
