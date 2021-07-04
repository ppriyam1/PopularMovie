//
//  MovieListTableViewController.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    let viewModel = MovieListViewModel()
    var movieListStructure : [MovieListStructure]?
    var pageNum = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MovieListTableViewCell.getNib(), forCellReuseIdentifier: MovieListTableViewCell.identifier)

        viewModel.enter { [weak self] results in
            if let results = results {
                self?.movieListStructure = results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieListStructure?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        
        cell.movieName.text = movieListStructure?[indexPath.row].title
        cell.popularityScore.text = movieListStructure?[indexPath.row].popularityScore
        cell.releaseYear.text = movieListStructure?[indexPath.row].releaseDate
        cell.movieGenre.text = movieListStructure?[indexPath.row].genre
        return cell
}
    //function to get genreString based on id
    
}
