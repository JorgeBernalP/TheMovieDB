//
//  MovieOptionManager.swift
//  TheMovieDB
//
//  Created by JorgeB on 16/02/22.
//

import Foundation

protocol OptionManagerDelegate {
    func didGetMovies(_ options: [Result])
}

struct OptionManager {
    
    var delegate: OptionManagerDelegate?
    
    let mdbURL = "https://api.themoviedb.org/3/discover"
    let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    
    func getMovies(_ type: String ,for genreID: Int) {
        
        let urlString = "\(mdbURL)/\(type)?api_key=\(apiKey)&with_genres=\(genreID)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    if let safeMovies = self.parseJSON(safeData) {
                        delegate?.didGetMovies(safeMovies)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ data: Data) -> [Result]? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(OptionData.self, from: data)
            
            let results = decodedData.results
            
            return results
            
        } catch {

            return []
            
        }
        
    }
    
}
