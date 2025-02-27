//
//  MovieListView.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 27/02/25.
//

import UIKit

class MoviewListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var loader = Loader()
    var tableView = UITableView()
    var movieListVM = MoviewListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListVM.fetchPopolarMovies()
        setupViews()
        movieListVM.delegate = self
    }
    
    func setupViews() {
        self.title = "Popular Movies"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = true
        loader.setupLoader(in: view)
        view.layoutIfNeeded()
        loader.startLoaderAnimation()
        setupTableView()
        view.bringSubviewToFront(loader)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        registerCells()
    }
    
    func registerCells() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieListVM.movies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = movieListVM.movies?.results[indexPath.row].title
        return cell
    }
}

extension MoviewListVC: MovieListVCDelegate {
    func didFetchData() {
        loader.stopLoaderAnimation()
        tableView.reloadData()
    }
}
