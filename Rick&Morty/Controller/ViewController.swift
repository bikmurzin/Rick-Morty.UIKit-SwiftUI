//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let queue = DispatchQueue.global(qos: .userInteractive)
    let spinner = SpinnerVC()
    var characters: Characters?
    var episodes: Episodes?
    var locations: Locations?
    let model = Model()
    var charactersView: CharactersView?
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 4/255, green: 13/255, blue: 30/255, alpha: 1)
        model.delegate = self
        configureView()
        queue.async {
            self.model.getCharacters()
        }        
    }
}

// MARK: Push To SwiftUI View
extension ViewController {
    func configureView() {
        charactersView = CharactersView(frame: view.frame)
        charactersView?.delegate = self
        guard let charactersView = charactersView else {return}
        view.addSubview(charactersView)
        charactersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            charactersView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

