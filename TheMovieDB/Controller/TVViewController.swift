//
//  TVViewController.swift
//  TheMovieDB
//
//  Created by JorgeB on 15/02/22.
//

import UIKit

class TVViewController: UITableViewController {

    var genreManager = GenreManager()
    
    var tvGenreArray: [String]?
    var tvGenreIdArray: [Int]?

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
        return tvGenreArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVGenreCell", for: indexPath)
        
        cell.textLabel?.text = tvGenreArray?[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SelectedTVGenre", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OptionsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.type = "tv"
            destinationVC.genreName = tvGenreArray?[indexPath.row]
            destinationVC.genreID = tvGenreIdArray?[indexPath.row]
        }
    }

}

extension TVViewController: GenreManagerDelegate {
    func didGetGenres(_ genres: [Genre]) {
        DispatchQueue.main.async {
            self.tvGenreArray = genres.map({ genre in
                genre.name
            })
            self.tvGenreIdArray = genres.map({ genre in
                genre.id
            })
            self.tableView.reloadData()
        }
    }
}

