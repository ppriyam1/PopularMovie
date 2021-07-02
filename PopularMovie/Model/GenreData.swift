//
//  GenreData.swift
//  PopularMovieApp
//
//  Created by Preeti Priyam on 6/30/21.
//

import Foundation

// MARK: - GenreData
struct GenreData: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

