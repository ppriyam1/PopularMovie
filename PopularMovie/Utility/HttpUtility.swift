//
//  HttpUtility.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import Foundation

struct URLConstants {
    
}

struct HttpUtility {
    
    static func getData <T: Decodable> (requestUrl: URL, resultType: T.Type, completion: @escaping(Result<T?, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
            }
        }
        
    }
}
