//
//  MovieTableViewCell.swift
//  MovieSearch_2.0
//
//  Created by Gavin Woffinden on 5/9/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Functions
    func updateViews() {
        
        guard let movie = movie else {return}
        
        movieTitleLabel.text = movie.title
        movieDescription.text = movie.description
        movieRatingLabel.text = "\(movie.rating)"
        
        MovieController.fetchPoster(for: movie) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let poster):
                    self.posterImage.image = poster
                case .failure(let error):
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    override func prepareForReuse() {
        posterImage.image = UIImage(systemName: "ImageNotAvailible")
    }
}
