//
//  MovieListTableViewController.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    private let viewModel = MovieListViewModel()
    private var movieListStructure : [MovieListStructure]?
    private var pageNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registed the nib file
        tableView.register(MovieListTableViewCell.getNib(), forCellReuseIdentifier: MovieListTableViewCell.identifier)
        fetchMovieData()
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
        
        //update pagenumber when all the page data displayed
        if indexPath.row == (movieListStructure!.count - 1) && pageNum <= 1000{
            pageNum += 1
            fetchMovieData()
        }
        cell.movieName.text = movieListStructure?[indexPath.row].title
        cell.popularityScore.text = movieListStructure?[indexPath.row].popularityScore
        cell.releaseYear.text = movieListStructure?[indexPath.row].releaseDate
        cell.movieGenre.text = movieListStructure?[indexPath.row].genre
        let movieImageUrl = URL(string: (movieListStructure?[indexPath.row].thumbnail)!)!
        print(movieImageUrl)
        cell.movieImage.loadImage(fromUrl: movieImageUrl, key : (movieListStructure?[indexPath.row].title)!)
        
        return cell
    }
    
    //func to fetch the data based on page number
    func fetchMovieData() {
        viewModel.enter(pageNumber: pageNum) { [weak self] results, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.handleDataLoaderFailure(error: error)
                }
            }
            if let results = results {
                self?.movieListStructure = results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
