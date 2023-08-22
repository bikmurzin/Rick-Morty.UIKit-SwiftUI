//
//  Episodes.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import Foundation

struct Episodes: Decodable {
    var info: Info
    var results: [Episode]
}
