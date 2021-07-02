//
//  MovieData.swift
//  PopularMovieApp
//
//  Created by Preeti Priyam on 6/30/21.
//

import Foundation

// MARK: - MovieData
struct MovieData: Codable {
    let page: Int?
    let results: [Results]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Results: Codable {
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

