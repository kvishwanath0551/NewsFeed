//
//  NetworkHandler.swift
//  NewsFeed
//
//  Created by Vishwanath on 11/08/21.
//

import Foundation

enum URLError : Error {
    case unformatedURL
    case dataNotFound
}

class URLConstants {
    static let factsURL = "https://newsapi.org/v2/everything?q=tesla&from=2021-07-11&sortBy=publishedAt&apiKey=1eafa4963925472bb1530f2cbd89b24a"
}

class Network {
    
    /// Get API Call
    static func getApiCallWithRequestString(requestString: String, completionBlock: @escaping((Result<Data, Error>) -> Void)) {
        
        guard let url = URL(string: requestString) else {
            completionBlock(.failure(URLError.unformatedURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (responseData, httpResponse, error) in
            
            if let err = error {
                completionBlock(.failure(err))
                return
            }
            
            guard let response = responseData else {
                completionBlock(.failure(URLError.dataNotFound))
                return
            }
            
            completionBlock(.success(response))
        }
        dataTask.resume();
    }
}
