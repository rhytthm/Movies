//
//  MovieListModel.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 27/02/25.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let vote: Double
    let voteCount: Int
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case title = "original_title"
        case vote = "vote_average"
        case voteCount = "vote_count"
        case poster = "poster_path"
    }
}
