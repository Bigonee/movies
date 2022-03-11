//
//  MoviesController.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Alamofire
import UIKit

class MoviesController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var moviesTable: UITableView!
    @IBOutlet var moviesSearchBar: UISearchBar!

    var movies: [Movie] = []
    var movieSelected: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTable.dataSource = self
        moviesTable.delegate = self
        moviesSearchBar.delegate = self
        searchMovies(searchText: "a")
    }
    
    /*
     * Movies
     */

    func searchMovies(searchText: String) {
        MoviesService.search(searchText: searchText) { moviesResult in
            self.movies = moviesResult
            self.moviesTable.reloadData()
        }
    }

    /*
     * Table
     */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8, animations: {
            cell.contentView.alpha = 1
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.item]
        performSegue(withIdentifier: "toMovieDetails", sender: self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movicell", for: indexPath) as! MovieCell

        let attributtedTitle = NSAttributedString(string: movies[indexPath.item].original_title, attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        cell.originalTitle.attributedText = attributtedTitle
        cell.overview.text = movies[indexPath.item].overview

        let value = movies[indexPath.item].vote_average
        let roundedValue = round(value * 10) / 10.0

        cell.voteAverage.text = "\(roundedValue)"
        cell.poster.alpha = 0
        MoviesService.getMoveImage(path: movies[indexPath.item].poster_path, completion: { posterImage in
            cell.poster.image = posterImage
            cell.poster.alpha = 1
        })
        cell.contentView.alpha = 0
        return cell
    }

    /*
     * SearchBar
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            searchMovies(searchText: searchText)
        }
    }
    
    /*
     * Segue
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MovieDetailsController {
            let vc = segue.destination as? MovieDetailsController
            vc?.movie = movieSelected
        }
    }
}
