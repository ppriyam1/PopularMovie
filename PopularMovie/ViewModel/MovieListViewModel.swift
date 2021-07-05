//
//  MovieListViewModel.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import UIKit

protocol MovieListDelegate{
    func checkResponse(error : Error?)
}

struct MovieListStructure {
    var title, releaseDate, genre, thumbnail, popularityScore : String
}

class MovieListViewModel {
    
    var delegate : MovieListDelegate?
    
    var movieListStructure : [MovieListStructure] = []
    private var movieData : MovieData?
    private var genreData : GenreData?
    
    //created dispatch group to get the genre name before fetching the movie data
    func enter(pageNumber : Int, completion : @escaping ([MovieListStructure]?) -> Void ) {
        let dispatchGroup = DispatchGroup()
        let networkClient = NetworkClient()
        
        //dispatch group to enter and leave the scope
        dispatchGroup.enter()
        if pageNumber == 1 {
            networkClient.getGenreData { [weak self] result, error in
                
                if error != nil {
                    self?.delegate?.checkResponse(error: error)
                }
                DispatchQueue.main.async {
                    if let result = result {
                        self?.genreData = result
                    }
                    print("getGenreData")
                    dispatchGroup.leave()
                }
            }
        }else{
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkClient.getMovieData(pageNumber: pageNumber) { [weak self] result, error in
            
            if error != nil {
                self?.delegate?.checkResponse(error: error)
            }
            //https://image.tmdb.org/t/p/w500/qIicLxr7B7gIt5hxZxo423BJLlK.jpg
            DispatchQueue.main.async {
                if let result = result {
                    self?.movieData = result
                    for index in 0..<(self?.movieData?.results?.count)! {
                        //appending all the data to the movielist structure
                        self?.movieListStructure.append(MovieListStructure(
                            title: (self?.movieData?.results?[index].title)!,
                            releaseDate: (self?.movieData?.results?[index].releaseDate)!,
                            genre: getGenre(genreIds: (self?.movieData?.results?[index].genreIDS)!),
                            thumbnail: ("https://image.tmdb.org/t/p/w500\(self?.movieData?.results?[index].posterPath ?? "")"),
                            popularityScore: String((self?.movieData?.results?[index].popularity)!)
                        ))
                    }
                }
                print("getMovieData")
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(self.movieListStructure)
        }
        
        //function to convert genreid to genreNames
        func getGenre(genreIds : [Int]) -> String {
            var genreString = ""
            for genreId in genreIds {
                if let geners = (genreData?.genres) {
                for genre in geners {
                    if genreId == genre.id {
                        genreString += genre.name! + ","
                        continue
                    }
                }
            }
            }
            genreString.remove(at: genreString.index(before: genreString.endIndex))
            return genreString
        }
    }
}
