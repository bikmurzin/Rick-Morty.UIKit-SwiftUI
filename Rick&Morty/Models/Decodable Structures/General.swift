//
//  General.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import Foundation

struct Info: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct Location: Decodable {
    var id: Int?
    var name: String?
    var type: String?
//    var dimension: String?
//    var residents: [String]?
    var url: String?
//    var created: String?
}

struct Episode: Decodable, Identifiable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
}
