//
//  TVViewController.swift
//  TheMovieDB
//
//  Created by JorgeB on 15/02/22.
//

import UIKit

class TVViewController: UITableViewController {

    var genreManager = GenreManager()
    
    var movieGenreArray: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        genreManager.delegate = self
        
        genreManager.getGenres(for: "tv")
        
        navigationItem.title = "Select a TV Genre"
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieGenreArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVGenreCell", for: indexPath)
        
        cell.textLabel?.text = movieGenreArray?[indexPath.row]
        
        return cell
        
    }

}

extension TVViewController: GenreManagerDelegate {
    func didGetGenres(_ genres: [Genre]) {
        DispatchQueue.main.async {
            self.movieGenreArray = genres.map({ genre in
                genre.name
            })
            self.tableView.reloadData()
        }
    }
}

