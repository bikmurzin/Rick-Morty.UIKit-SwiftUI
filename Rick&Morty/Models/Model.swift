//
//  Model.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import Foundation

final class Model {
    let group = DispatchGroup()
    let queue = DispatchQueue.global(qos: .userInteractive)
    let charactersURL = URL(string: "https://rickandmortyapi.com/api/character")
    let locationsURL = URL(string: "https://rickandmortyapi.com/api/location")
    let episodesURL = URL(string: "https://rickandmortyapi.com/api/episode")
    weak var delegate: ViewControllerDelegateForModel? = nil
    var characters: Characters?
    var episodes: Episodes?
    var locations: Locations?
    var countOfNewElements = 0
    var location: Location?
    var networkLayer = NetworkLayer()
}

//MARK: Загрузка данных для CharactersView
extension Model {
    func getCharacters(fromURL: URL? = nil) {
        DispatchQueue.main.async {
            self.delegate?.moveIndicator()
        }
        var url: URL? = nil
        if let unwrURL = fromURL {
            url = unwrURL
        } else {url = charactersURL}
        networkLayer.loadData(url: url) { success, data in
            if success {
                var tmpCharacters: Characters? = nil
                if let data = data {
                    self.networkLayer.dataTransformation(object: &tmpCharacters, data: data)
                    if let unwrTmpCharacters = tmpCharacters {
                        self.countOfNewElements = unwrTmpCharacters.results.count
                        if self.characters != nil {
                            self.characters?.results.append(contentsOf: unwrTmpCharacters.results)
                            self.characters?.info.next = unwrTmpCharacters.info.next
                        } else {
                            self.characters = tmpCharacters
                        }
                    }
                }
                self.getCharacterImage()
                self.group.notify(queue: self.queue) {
                    DispatchQueue.main.async {
                        self.delegate?.stopIndicator()
                        self.delegate?.reloadCollectionView(countOfNewElements: self.countOfNewElements)
                    }
                }
            } else {
                print("Network request failed")
            }
        }
    }
    
    func getCharacterImage(index: Int = 0) {
        guard let characters = self.characters else {return}
        for i in 0..<characters.results.count {
            if characters.results[i].imageData == nil {
                if let unwrStringURL = characters.results[i].imageURL {
                    let url = URL(string: unwrStringURL)
                    DispatchQueue.main.async {
                        self.delegate?.moveIndicator()
                    }
                    self.group.enter()
                    self.queue.async {
                        self.networkLayer.loadData(url: url) { success, data in
                            if success {
                                self.characters?.results[i].imageData = data
                                self.group.leave()
                            } else {
                                print("Загрузка изображения не удалась")
                                self.group.leave()
                            }
                        }
                    }
                }
            }
        }
    }
}
