//
//  ProtocolsImplementation.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import Foundation
import SwiftUI

extension ViewController: ViewControllerDelegateForModel {
    func reloadCollectionView(countOfNewElements: Int) {
        if model.countOfNewElements == model.characters?.results.count {
            charactersView?.charactersCollectionView.reloadData()
        } else {
            var paths = [IndexPath]()
            if let countOfElementsInArray = charactersView?.characters?.results.count {
                for item in 0..<countOfNewElements {
                    let indexPath = IndexPath(row: item + countOfElementsInArray, section: 0)
                    paths.append(indexPath)
                }
                charactersView?.charactersCollectionView.insertItems(at: paths)
                charactersView?.isBottomReached = false
            }
        }
    }
    
    // MARK: Запуск и остановка спиннера
    //Метод для остановки Spinner
    func stopIndicator() {
        self.spinner.willMove(toParent: nil)
        self.spinner.view.removeFromSuperview()
        self.spinner.removeFromParent()
    }
    
    //Метод для добавления Spinner в основное вью
    func moveIndicator() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
}

extension ViewController: ViewControllerDelegateForCharactersView {
    func showDetailView(character: Personage) {
        let host = UIHostingController(rootView: MainScreen(character: character))
        navigationController?.pushViewController(host, animated: true)
    }
    
    func loadMoreCharacters() {
        guard let characters = model.characters,
              let stringURL = characters.info.next
        else {return}
        let url = URL(string: stringURL)
        model.getCharacters(fromURL: url)
    }
    
    func getCharacters() -> Characters? {
        return model.characters
    }
}
