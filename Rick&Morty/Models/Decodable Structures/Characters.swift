//
//  DecodableStructures.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import Foundation
import UIKit

struct Characters: Decodable {
    var info: Info
    var results: [Personage]
}

struct Personage: Decodable {
    var id: Int
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: Origin?
    var location: Location?
    var imageURL: String?
    var episode: [String]?
    var url: String?
    var created: String?
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, episode, url, created
        case imageURL = "image"
    }
    
}

struct Origin: Decodable {
    var name: String
    var url: String
}
