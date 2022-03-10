//
//  MoviesService.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Alamofire
import Foundation

class MoviesService {
    
    static func getMovie(id: Int,  completion:@escaping (Movie)->Void) {
                 
        AF.request(MoviesEndPoint.get(id)).responseData { response in
            switch response.result {
            case let .success(result):
                do {
                    let decoder = JSONDecoder();
                    let movie = try decoder.decode(Movie.self, from: result)
                    completion(movie);

                } catch let error {
                    print("---- ERRORR -----")
                    print(response.response?.statusCode)
                    print(error)
                }

                //print(String(data: value, encoding: .utf8)!)
            case let .failure(error):
                print("---- failure -----")
                print(error)
            }
        }
                
       
    }
    
    static func search(completion: @escaping (Movie) -> ()) {
                 
        AF.request(MoviesEndPoint.search).responseData { response in
            switch response.result {
            case let .success(result):
                do {
                    let decoder = JSONDecoder();
                    let movie = try decoder.decode(Movie.self, from: result)
                    completion(movie);

                } catch let error {
                    print("---- ERRORR -----")
                
                    print(error)
                }

                //print(String(data: value, encoding: .utf8)!)
            case let .failure(error):
                print("---- failure -----")
                print(error)
            }
        }
                
       
    }
}
