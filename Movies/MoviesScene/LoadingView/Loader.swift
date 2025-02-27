//
//  Loader.swift
//  Movies
//
//  Created by RAJEEV MAHAJAN on 27/02/25.
//

import UIKit

class Loader: UIView {
    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    func setupLoader(in parentView: UIView) {
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            self.topAnchor.constraint(equalTo: parentView.topAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
        
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 100),
            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        containerView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func startLoaderAnimation() {
        activityIndicator.startAnimating()
        self.isHidden = false
    }
    
    func stopLoaderAnimation() {
        activityIndicator.stopAnimating()
        self.isHidden = true
    }
}
