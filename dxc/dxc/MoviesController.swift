//
//  MoviesController.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Alamofire
import UIKit

class MoviesController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTable.dataSource = self;
        moviesTable.delegate = self;
        moviesSearchBar.delegate = self;
      
     
    }
    
    func searchMovies(searchText: String){
        MoviesService.search(searchText: searchText) { moviesResult in
            self.movies = moviesResult;
            self.moviesTable.reloadData();
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movicell", for: indexPath) as! MovieCell
        cell.originalTitle.text = self.movies[indexPath.item].original_title;        
        let imageUrl = "https://image.tmdb.org/t/p/w200/\(self.movies[indexPath.item].poster_path)";
        let url = URL(string: imageUrl);
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.poster.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1 {
            self.searchMovies(searchText: searchText);
        } else {
           
        }
      
    }
}

