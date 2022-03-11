//
//  Movie.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let original_title: String
    let overview: String
    let vote_average: Float
    let poster_path: String
    
}

struct MoviesResult: Codable {
    let page: Int
    let results: [Movie]
}
