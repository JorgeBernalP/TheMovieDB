//
//  GenreManager.swift
//  TheMovieDB
//
//  Created by JorgeB on 15/02/22.
//

import Foundation

protocol GenreManagerDelegate {
    func didGetGenres(_ genres: [Genre])
}

struct GenreManager {
    
    var delegate: GenreManagerDelegate?
    
    let mdbURL = "https://api.themoviedb.org/3/genre"
    let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    
    func getGenres(for type: String) {
        
        let urlString = "\(mdbURL)/\(type)/list?api_key=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    if let safeGenres = self.parseJSON(safeData) {
                        delegate?.didGetGenres(safeGenres)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ data: Data) -> [Genre]? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(Genres.self, from: data)
            
            let genres = decodedData.genres
            
            return genres
            
        } catch {

            return []
            
        }
        
    }
    
}
