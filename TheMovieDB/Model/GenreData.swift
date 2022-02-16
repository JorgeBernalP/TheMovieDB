//
//  GenreData.swift
//  TheMovieDB
//
//  Created by JorgeB on 15/02/22.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
