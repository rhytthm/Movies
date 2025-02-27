//
//  MoviewListVM.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 27/02/25.
//

import Foundation
protocol MovieListVCDelegate: AnyObject {
    func didFetchData()
}

class MoviewListVM {
    weak var delegate: MovieListVCDelegate?
    var movies: MovieList?
    
    func fetchPopolarMovies() {
        NetworkManager.shared.sendRequest(endpoint: MovieListEndpoints.popularList(page: 0)) { (response: Result<MovieList,Error>) in
            switch response {
                case .success(let data):
                    self.movies = data
                DispatchQueue.main.async(execute: {
                    self.delegate?.didFetchData()
                })
                    print(data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
