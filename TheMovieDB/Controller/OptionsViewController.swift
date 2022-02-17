//
//  OptionsViewController.swift
//  TheMovieDB
//
//  Created by JorgeB on 15/02/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class OptionsViewController: UICollectionViewController {
    
    var optionManager = OptionManager()
    
    var type: String?
    var genreName: String?
    var genreID: Int?
    
    var optionsImagesArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(genreName!)"
        
        optionManager.delegate = self
        
        optionManager.getMovies(type!, for: genreID!)
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return optionsImagesArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mdbImageUrl = "https://image.tmdb.org/t/p/w500\(optionsImagesArray?[indexPath.row] ?? "")"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let url = URL(string: mdbImageUrl)
        {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url)
                {
                    DispatchQueue.main.async {
                        let view = UIView()
                        let imageView = UIImageView(image: UIImage(data: data)!)
                        imageView.frame = CGRect(x: 0, y: 0, width: 131, height: 197)
                        view.addSubview(imageView)
                        view.bringSubviewToFront(imageView)
                        cell.backgroundView = view
                    }
                }
            }
        }
        
        return cell
    }
    
}

extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 131, height: 197)
    }
    
}

extension OptionsViewController: OptionManagerDelegate {
    
    func didGetMovies(_ options: [Result]) {
        DispatchQueue.main.async {
            self.optionsImagesArray = options.map({ movie in
                movie.posterPath
            })
            self.collectionView.reloadData()
        }
    }
    
}
