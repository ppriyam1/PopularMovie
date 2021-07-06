//
//  MovieListViewModel.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import UIKit

struct MovieListStructure {
    var title, releaseDate, genre, thumbnail, popularityScore : String
}

class MovieListViewModel {
    
    var movieListStructure : [MovieListStructure] = []
    private var movieData : MovieData?
    private var genreData : GenreData?
    
    //created dispatch group to get the genre name before fetching the movie data
    func enter(pageNumber : Int, completion : @escaping ([MovieListStructure]?,Error?) -> Void ) {
        let dispatchGroup = DispatchGroup()
        let networkClient = NetworkClient()
        
        //dispatch group to enter and leave the scope
        dispatchGroup.enter()
        if pageNumber == 1 {
            networkClient.getGenreData { [weak self] result, error in
                
                if error != nil {
                    completion(nil,error)
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
                completion(nil,error)
            }
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
            completion(self.movieListStructure,nil)
        }
        
        //function to convert genreid to genreNames
        func getGenre(genreIds : [Int]) -> String {
            var genreString = ""
            for genreId in genreIds {
                if let geners = (genreData?.genres) {
                    for genre in geners {
                        if genreId == genre.id {
                            genreString += genre.name! + ", "
                            continue
                        }
                    }
                }
            }
            return String(genreString.dropLast(2))
        }
    }
}

extension MovieListTableViewController {
    //method to handle error
    func handleDataLoaderFailure(error: Error) {
        
        let title: String, message: String
        
        switch (error as? NetworkManager.ResponseError) ?? .unknown {
        case .badResponseStatusCode:
            title = NSLocalizedString("MovieListEmptyTitle", comment: "")
            message = NSLocalizedString("MovieListEmptyMessage", comment: "")
            
        case .NetworkingError:
            title = NSLocalizedString("MissingHttpResponseTitle", comment: "")
            message = NSLocalizedString("MissingHttpResponseFailureMessage", comment: "")
            
        case .unknown:
            title = NSLocalizedString("MovieListLoadFailureTitle", comment: "")
            message = NSLocalizedString("MovieListLoadFailureTitle", comment: "")
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)
        
        alert.addAction(action)
        alert.preferredAction = action
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
