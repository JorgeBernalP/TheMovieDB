//
//  MovieViewController.swift
//  TheMovieDB
//
//  Created by JorgeB on 15/02/22.
//

import UIKit

class MovieViewController: UITableViewController {
    
    var genreManager = GenreManager()
    
    var movieGenreArray: [String]?
    var movieGenreIdArray: [Int]?

    override func viewDidLoad() {
        super.viewDidLoad()

        genreManager.delegate = self
        
        genreManager.getGenres(for: "movie")
        
        navigationItem.title = "Select a Movie Genre"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieGenreArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieGenreCell", for: indexPath)
        
        cell.textLabel?.text = movieGenreArray?[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SelectedMovieGenre", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OptionsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.type = "movie"
            destinationVC.genreName = movieGenreArray?[indexPath.row]
            destinationVC.genreID = movieGenreIdArray?[indexPath.row]
        }
    }
    
    

}

extension MovieViewController: GenreManagerDelegate {
    func didGetGenres(_ genres: [Genre]) {
        DispatchQueue.main.async {
            self.movieGenreArray = genres.map({ genre in
                genre.name
            })
            self.movieGenreIdArray = genres.map({ genre in
                genre.id
            })
            self.tableView.reloadData()
        }
    }
}
