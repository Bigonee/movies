//
//  MoviesService.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Alamofire
import Foundation

class MoviesService {
    static func getMovie(id: Int, completion: @escaping (Movie) -> Void) {
        AF.request(MoviesEndPoint.get(id)).responseData { response in
            switch response.result {
            case let .success(result):
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(Movie.self, from: result)
                    completion(movie)
                } catch let error {
                    print("---- ERRORR -----")
                    print(error)
                }
            // print(String(data: value, encoding: .utf8)!)
            case let .failure(error):
                print("---- failure -----")
                print(error)
            }
        }
    }

    static func search(searchText: String, completion: @escaping ([Movie]) -> Void) {
        AF.request(MoviesEndPoint.search(searchText)).responseData { response in

            switch response.result {
            case let .success(result):
                do {
                    print(result)
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(MoviesResult.self, from: result)
                    completion(movies.results)

                } catch let error {
                    print("---- ERRORR -----")
                    print(error)
                }

            // print(String(data: value, encoding: .utf8)!)
            case let .failure(error):
                print("---- failure -----")
                print(error)
            }
        }
    }

    static func getMoveImage(path: String, completion: @escaping (UIImage) -> Void) {
        let imageUrl = Constants.baseURLImages + path
        let url = URL(string: imageUrl)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                completion(UIImage(data: data!)!)
            }
        }
    }
}
