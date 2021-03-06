//
//  MovieDetailsController.swift
//  dxc
//
//  Created by marc icart on 11/3/22.
//

import Foundation

import UIKit

class MovieDetailsController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    var movie: Movie!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.loadMovieDetails();
    }
    
    func loadMovieDetails() {      
        self.originalTitle.text = movie.original_title;
        self.overview.text = movie.overview;
        self.voteAverage.text = "\(movie.vote_average)";
        MoviesService.getMoveImage(path: movie.poster_path, completion: { posterImage in
            self.poster.image = posterImage;
        });
    }
    
    
    
}
