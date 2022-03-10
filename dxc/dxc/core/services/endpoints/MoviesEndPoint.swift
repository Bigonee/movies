//
//  MoviesEndPoint.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Alamofire
import Foundation

enum MoviesEndPoint: URLRequestConvertible {
    static let baseURLString = "https://api.themoviedb.org/3/"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZGNhNmUzYzViNzhhNmIwYWIyZTZhZDViODU3ZWRlMSIsInN1YiI6IjYyMmEwMGIyZDIzNmU2MDA2ZGY5NDBhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JDgCabQYVfRrMrAhfFAtp3xGxH5EfaMoJQxia31kbUU"
    static let api_key = "7dca6e3c5b78a6b0ab2e6ad5b857ede1"

    case get(Int)
    case search(String)

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            case .search:
                return .get
            }
        }

        let params: ([String: Any]?) = {
            switch self {
            case .get:
                return nil
            case let .search(searchText):
                return ["query": searchText]
            }
        }()

        var url: URL = {
            let relativePath: String?
            switch self {
            case let .get(id):
                relativePath = "movie/\(id)"
            case .search:
                relativePath = "search/movie"
            }

            var url = URL(string: MoviesEndPoint.baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }

            return url
        }()

        var urlComponents = URLComponents(string: "\(url)")

        switch self {
        case .get:
            urlComponents?.queryItems = [
                URLQueryItem(name: "api_key", value: MoviesEndPoint.api_key),
            ]
        case let .search(searchText):
            urlComponents?.queryItems = [
                URLQueryItem(name: "api_key", value: MoviesEndPoint.api_key),
                URLQueryItem(name: "query", value: "\(searchText)")]
        }

        url = (urlComponents?.url)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
     
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
