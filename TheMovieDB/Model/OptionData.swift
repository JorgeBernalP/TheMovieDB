//
//  MovieOptionData.swift
//  TheMovieDB
//
//  Created by JorgeB on 16/02/22.
//

import Foundation

// MARK: - OptionData
struct OptionData: Codable {
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
    }
}
