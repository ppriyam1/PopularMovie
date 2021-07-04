//
//  APIManager.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import Foundation

struct URLConstants {
    static let movieURL = "https://api.themoviedb.org/3/movie/popular?api_key=7ebb2ed4d9371279b5c8b09175fc2f02&language=en-US&page="
    static let genreURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=7ebb2ed4d9371279b5c8b09175fc2f02&language=en-US"
}

struct NetworkClient {
    
    let networkManger = NetworkManager()
    
    //method fetch the genre of the popular movies
    func getGenreData(completion: @escaping(GenreData?,Error?) -> Void) {
        if let url = URL(string: URLConstants.genreURL) {
            networkManger.getData(requestUrl: url, resultType: GenreData.self) { (result : Result<GenreData?, Error>) in
                switch result {
                case .success(let responseData) :
                    completion(responseData,nil)
                case .failure(let error) :
                    completion(nil, error)
                }
            }
        }
    }
    
    //method to call the method of network manager to fetch the popular movie data based on the page number
    func getMovieData(pageNumber : Int, completion: @escaping(MovieData?,Error?) -> Void) {
        if let url = URL(string: URLConstants.movieURL + "\(pageNumber)") {
            networkManger.getData(requestUrl: url, resultType: MovieData.self) { (result : Result<MovieData?, Error>) in
                switch result {
                case .success(let responseData) :
                    completion(responseData,nil)
                case .failure(let error) :
                    completion(nil, error)
                }
            }
        }
    }
}
