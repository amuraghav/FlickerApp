//
//  ServiceManager.swift
//  FlickerApp
//
//  Created by Pankaj Raghav on 27/07/19.
//  Copyright © 2019 Pankaj Raghav. All rights reserved.
//

import Foundation

// MARK:- BASE URL
let baseUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text="

// MARK:- NETWORK ERROR
enum NetworkError:Error {
    
    case unableToParse
    case noData
    case unknown
    case requestTimedOut
    case noInternet
}

// MARK:- API REQUEST MODEL

struct APIRequest{
    let url: URL
    init(url: String) {
        let percentEncodedURLString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.url = Foundation.URL(string: percentEncodedURLString!)!
    }
}


class ServiceManager: NSObject{
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    // MARK:- API CALLING METHOD
    
    func performRequest<T : Decodable>(request: APIRequest, completion: @escaping (Swift.Result<T , NetworkError>) -> Void) {
        dataTask = defaultSession.dataTask(with: request.url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                print("Error : \(error)")
                completion(.failure(.unknown))
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                do{
                    let values =  try JSONDecoder().decode(T.self, from: data)
                    completion(.success(values))
                }
                catch{
                    print("UNABLE TO PARSE STATUS CODE : \(error)")
                    completion(.failure(.unableToParse))
                }
            }
        }
        dataTask?.resume()
    }
    
}




