//
//  MovieListTableViewCell.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/2/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var popularityScore: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    
    static let identifier = "MovieListTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func getNib() -> UINib{
        return UINib(nibName: MovieListTableViewCell.identifier, bundle: nil)
    }
    
}
