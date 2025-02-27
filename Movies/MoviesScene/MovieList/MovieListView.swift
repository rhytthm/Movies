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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieListVM.movies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        // Setting text
        cell.textLabel?.text = movieListVM.movies?.results[indexPath.row].title
        
        // Loading image
        if let url = URL(string: MovieListEndpoints.image(path: movieListVM.movies?.results[indexPath.row].poster ?? "").imgUrl) {
            loadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.imageView?.isHidden = false
                    cell.setNeedsLayout()  // Force the cell to re-layout
                }
            }
        } else {
            cell.imageView?.isHidden = true  // Hide imageView if URL is nil
        }

        // Return the cell
        return cell
    }

    // Assuming your loadImage function is asynchronous and uses a completion handler
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

extension MoviewListVC: MovieListVCDelegate {
    func didFetchData() {
        loader.stopLoaderAnimation()
        tableView.reloadData()
    }
}
