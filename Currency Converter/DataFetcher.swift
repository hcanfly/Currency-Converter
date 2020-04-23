//
//  DataFetcher.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation


// download data and decode from JSON
func fetchData<T: Decodable>(url: URL?, myType: T.Type, completion: @escaping (T) -> Void) {
      guard let url = url else {
        fatalError("InvalidURL")        // should never happen unless API changes or something
      }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data {
            //print(String(bytes: data, encoding: String.Encoding.utf8))
            let jsonDecoder = JSONDecoder()
            //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let theData = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(theData)
                }
            } catch {
                print("Error parsing JSON")
            }
        } else {
            print("Download error: " + error!.localizedDescription)
        }
    }

    task.resume()
}


let baseURLString = "https://api.exchangeratesapi.io/latest?base="

func getExchangeValues<T: Decodable>(for currency: String, myType: T.Type, completion: @escaping (T) -> Void) {

    fetchData(url: .exchangeRates(for: currency), myType: T.self) { rates in
         completion(rates)
     }
}

extension URL {

    static func exchangeRates(for currency: String) -> URL? {
        URL(string: baseURLString + "\(currency)")
    }

}
