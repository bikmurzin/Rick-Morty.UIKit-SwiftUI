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


// MARK: Работа с сетевыми запросами
extension Model {
    func dataTransformation<T: Decodable>(object: inout T, data: Data) {
        let decoder = JSONDecoder()
        do{
            object = try decoder.decode(T.self, from: data)
        } catch let error as NSError {
            print("Ошибка при преобразовании:: \(error)")
        }
    }
    
    func loadData(url: URL?, _ completion: @escaping (_ success: Bool, _ data: Data?) -> Void) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(true, data)
            } else {
                completion(false, nil)
            }
        }
        task.resume()
    }
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
        loadData(url: url) { success, data in
            if success {
                var tmpCharacters: Characters? = nil
                if let data = data {
                    self.dataTransformation(object: &tmpCharacters, data: data)
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
                        self.loadData(url: url) { success, data in
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

//MARK: Загрузка данных для DetailsScreen
extension Model {
    func loadLocation(stringURL: String?, group2: DispatchGroup) {
        print("Loading location...")
        guard let stringURL = stringURL else {
            print("Invalid URL")
            return
        }
        let url = URL(string: stringURL)
        group2.enter()
        queue.async {
            if stringURL.isEmpty {
                self.location = Location(id: 1, name: "Unknown", type: "Unknown")
                group2.leave()
                return
            }
            self.networkLayer.loadData(url: url) { success, data in
                if success {
                    if let data = data {
                        self.networkLayer.dataTransformation(object: &self.location, data: data)
                    } else {
                        print("data is invalid")
                    }
                    print("Location loaded")
                    group2.leave()
                } else {
                    print("Network request failed")
                    group2.leave()
                }
            }
        }
    }
}
