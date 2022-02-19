//
//  SelectedTVData.swift
//  TheMovieDB
//
//  Created by JorgeB on 18/02/22.
//

import Foundation

struct SelectedTVData: Codable {
    let backdropPath: String
    let episodeRunTime: [Int]
    let firstAirDate: String
    let id: Int
    let originalName: String
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id = "id"
        case originalName = "original_name"
        case overview = "overview"
        case firstAirDate = "first_air_date"
        case episodeRunTime = "episode_run_time"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

