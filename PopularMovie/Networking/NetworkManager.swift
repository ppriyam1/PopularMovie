//
//  HttpUtility.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import Foundation

struct NetworkManager {
    
    enum ResponseError: Error {
        case badResponseStatusCode(Int)
        case NetworkingError(Error)
        case unknown
        
    }
    func getData <T: Decodable> (requestUrl: URL, resultType: T.Type, completion: @escaping(Result<T?, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { data, urlResponse, error in
            
            let result: Result<T?, Error>
            
            do {
                if let error = error as NSError? {
                    throw ResponseError.NetworkingError(error)
                }
                
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                    let error = NSError(domain: "Networking Error", code: 1, userInfo: userInfo)
                    throw ResponseError.NetworkingError(error)
                }
                
                guard (200 ..< 300).contains(urlResponse.statusCode) else {
                    throw ResponseError.badResponseStatusCode(urlResponse.statusCode)
                }
                
                let response = try JSONDecoder().decode(T.self, from: data ?? Data())
                result = .success(response)
            }catch {
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                //Sending data
                completion(result)
            }
        }.resume()
        
    }
}
