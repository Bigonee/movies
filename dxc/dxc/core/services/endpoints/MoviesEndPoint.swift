//
//  MoviesEndPoint.swift
//  dxc
//
//  Created by marc icart on 10/3/22.
//

import Alamofire
import Foundation

enum MoviesEndPoint: URLRequestConvertible {
    
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

            var url = URL(string: Constants.baseURL)!;
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }

            return url
        }()

        var urlComponents = URLComponents(string: "\(url)")

        switch self {
        case .get:
            urlComponents?.queryItems = [
                URLQueryItem(name: "api_key", value: Constants.api_key),
            ]
        case let .search(searchText):
            urlComponents?.queryItems = [
                URLQueryItem(name: "api_key", value: Constants.api_key),
                URLQueryItem(name: "query", value: "\(searchText)")]
        }

        url = (urlComponents?.url)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
     
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
