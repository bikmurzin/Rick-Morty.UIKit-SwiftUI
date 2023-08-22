//
//  SpinnerVC.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 19.08.2023.
//
import UIKit

class SpinnerVC: UIViewController {
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        //Настройки View
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
