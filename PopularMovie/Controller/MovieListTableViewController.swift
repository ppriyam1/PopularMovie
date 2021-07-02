//
//  MovieListTableViewController.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MovieListTableViewCell.getNib(), forCellReuseIdentifier: MovieListTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
