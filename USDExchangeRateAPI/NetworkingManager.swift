//
//  NetworkingManager.swift
//  USDExchangeRateAPI
//
//  Created by Sy Lee on 2022/06/08.
//

// URL: https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=HCBiZ4wSwjer7d3VzKzaZQgHTkeCTFs5&searchdate=2022-06-07&data=AP01
import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "BadURLResponse from url: \(url)"
            case .unknown:
                return "[⚠️]There is unknown error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { try responseHandler(output: $0, url: url)}
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func responseHandler(output: (URLSession.DataTaskPublisher.Output), url: URL) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            (200..<300).contains(response.statusCode) else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    static func completionHandler(completion: (Subscribers.Completion<Error>)) {
        switch completion {
        case .finished
            : break
        case .failure(let error)
            : print("error: \(error.localizedDescription)")
        }
    }
}
