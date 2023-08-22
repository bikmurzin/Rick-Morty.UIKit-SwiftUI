//
//  CharacterDetails.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import Foundation

class CharacterDetails {
    var stringURL: String?
    let networkLayer = NetworkLayer()
//    var queue = DispatchQueue.global(qos: .userInteractive)
    var location: Location?
    var isLoading: Bool = true
    
    func getLocation() {
        guard let stringURL = stringURL,
              let url = URL(string: stringURL)
        else {return}
        networkLayer.loadData(url: url) { success, data in
            if success {
                guard let data = data else {return}
                self.networkLayer.dataTransformation(object: &self.location, data: data)
                self.isLoading = false
                print(self.location)
            } else {
                print("Network request failed")
            }
        }
    }
}
