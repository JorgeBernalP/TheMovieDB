//
//  SelectedManager.swift
//  TheMovieDB
//
//  Created by JorgeB on 18/02/22.
//

import Foundation

protocol SelectedManagerDelegate {
    func didGetSelectedOptionDetails(selected: Selected)
}

struct SelectedManager {
    
    var delegate: SelectedManagerDelegate?
    
    let mdbURL = "https://api.themoviedb.org/3"
    let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    
    func getSelectedOptionDetails(type: String, for id: String) {
        
        let urlString = "\(mdbURL)/\(type)/\(id)?api_key=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    if let safeSelected = self.parseJSON(safeData, type) {
                        delegate?.didGetSelectedOptionDetails(selected: safeSelected)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ data: Data, _ type: String) -> Selected? {
        
        let decoder = JSONDecoder()
        
        if type == "movie" {
            
            do {
                
                let decodedData = try decoder.decode(SelectedMovieData.self, from: data)
                
                let selected = Selected(title: decodedData.title, image: decodedData.backdropPath, releaseDate: decodedData.releaseDate, ratingCount: decodedData.voteCount, ratingAverage: decodedData.voteAverage, runtime: decodedData.runtime, overview: decodedData.overview)
                
                return selected
                
            } catch {

                return nil
                
            }
            
        } else if type == "tv" {
            
            do {
                
                let decodedData = try decoder.decode(SelectedTVData.self, from: data)
                
                let selected = Selected(title: decodedData.name, image: decodedData.backdropPath, releaseDate: decodedData.firstAirDate, ratingCount: decodedData.voteCount, ratingAverage: decodedData.voteAverage, runtime: decodedData.episodeRunTime[0], overview: decodedData.overview)
                
                return selected
                
            } catch {

                return nil
                
            }
            
        } else {
            
            return nil
            
        }
        
    }
    
}
