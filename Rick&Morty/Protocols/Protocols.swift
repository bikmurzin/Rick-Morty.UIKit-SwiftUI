//
//  Protocols.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import Foundation

// MARK: Protocols
protocol ViewControllerDelegateForModel: AnyObject {
    func moveIndicator()
    func stopIndicator()
    func reloadCollectionView(countOfNewElements: Int)
}

protocol ViewControllerDelegateForCharactersView: AnyObject {
    func getCharacters() -> Characters?
    func loadMoreCharacters()
    func showDetailView(character: Personage)
}


