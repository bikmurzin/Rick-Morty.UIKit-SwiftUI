//
//  DetailModel.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 24.08.2023.
//

import Foundation

class DetailsModel: ObservableObject {
    @Published var isLoading: Bool = true
    var episodes: [Episode] = []
    var location: Location = Location(id: 1, name: "Unknown", type: "Unknown")
    var group = DispatchGroup()
    var queue = DispatchQueue.global(qos: .userInteractive)
    var networkLayer = NetworkLayer()
    
    func getDetails(episodesURLs: [String?], locationURL: String?) {
//        isLoading = true
        loadEpisodes(stringURLArray: episodesURLs)
        loadLocation(stringURL: locationURL)
        group.notify(queue: queue) {
            DispatchQueue.main.async {
                self.isLoading = false
                self.episodes.sort { ep1, ep2 in
                    ep1.id < ep2.id
                }
            }
        }
    }
    
    func loadEpisodes(stringURLArray: [String?]) {
        episodes.removeAll()
        for stringURL in stringURLArray {
            if let stringURL = stringURL {
                let url = URL(string: stringURL)
                group.enter()
                queue.async {
                    self.networkLayer.loadData(url: url) { success, data in
                        if success {
                            if let data = data {
                                var episode: Episode?
                                self.networkLayer.dataTransformation(object: &episode, data: data)
                                if let unwrEpisode = episode {
                                    self.episodes.append(unwrEpisode)
                                }
                            }
                            self.group.leave()
                        } else {
                            print("Network request failed")
                            self.group.leave()
                        }
                    }
                }
            }
        }
    }
    
    func loadLocation(stringURL: String?) {
        guard let stringURL = stringURL else {
            print("Invalid URL")
            location = Location(id: 1, name: "Unknown", type: "Unknown")
            return
        }
        let url = URL(string: stringURL)
        group.enter()
        queue.async {
            if stringURL.isEmpty {
                self.location = Location(id: 1, name: "Unknown", type: "Unknown")
                self.group.leave()
                return
            }
            self.networkLayer.loadData(url: url) { success, data in
                if success {
                    if let data = data {
                        self.networkLayer.dataTransformation(object: &self.location, data: data)
                    } else {
                        print("data is invalid")
                    }
                    self.group.leave()
                } else {
                    print("Network request failed")
                    self.group.leave()
                }
            }
        }
    }
}
