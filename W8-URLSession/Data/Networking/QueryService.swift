//
//  QueryService.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 04/05/2021.
//

import Foundation

class QueryService {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    
    func getSearchResults(searchTerm: String, completion: @escaping (_ response: [DrinkItem]?,_ error: ErrorResponse?) -> Void) {
        dataTask?.cancel()
        guard var urlComponents = URLComponents(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?") else { return }
        urlComponents.query = "s=\(searchTerm)"
        guard let url = urlComponents.url else { return }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let responseData = data else {
                        completion(nil,.noData)
                        return
                    }
                    let decoder = JSONDecoder()
                    guard let result = try? decoder.decode(Drinks.self, from: responseData) else { return }
                    guard let resultData = result.drinks else {
                        completion(nil,.noData)
                        return
                    }
                    if !resultData.isEmpty {
                        completion(resultData,nil)
                    }
                } else {
                    let errorResponse = ErrorResponse(responseDataStatus: response)
                    completion(nil,errorResponse)
                }
            }
        }
        dataTask?.resume()
    }
}
