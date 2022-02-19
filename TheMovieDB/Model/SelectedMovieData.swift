//
//  SelectedData.swift
//  TheMovieDB
//
//  Created by JorgeB on 18/02/22.
//

import Foundation

struct SelectedMovieData: Codable {
    let backdropPath: String
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id = "id"
        case title = "title"
        case overview = "overview"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
