//
//  MovieListEndpoints.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 27/02/25.
//
import UIKit

public enum MovieListEndpoints {
    case popularList(page: Int)
    case image(path: String)
}

extension MovieListEndpoints: RequestObject {
    var method: HttpMethods {
        .get
    }
    
    var scheme: String {
        "https"
    }
    
    var baseUrl: String {
        switch self {
        case .popularList(page: _):
            return "api.themoviedb.org"
        default:
            return ""
        }
    }
    
    var imgUrl: String {
        switch self {
        case .image(path: let path):
            return "https://image.tmdb.org/t/p/w500" + path
        default:
            return ""
        }
    }
    
    var path: String {
        switch self {
        case .popularList(page: _):
                return "/3/movie/popular"
        case .image(path: _):
                return ""
        }
    }
    
    var headers: [String : String]? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return ["Authorization": "Bearer \(apiKey)", "accept": "application/json"]
    }
    
    var queryParams: [String : String]? {
        let queryParams: [String : String] = [:]
        return queryParams
    }
    
    var bodyParams: [String : Any]? {
       nil
    }
    
}
