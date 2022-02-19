//
//  SelectedViewController.swift
//  TheMovieDB
//
//  Created by JorgeB on 18/02/22.
//

import UIKit

class SelectedViewController: UIViewController {
    
    @IBOutlet weak var selectedTitle: UILabel!
    @IBOutlet weak var selectedReleaseDate: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var selectedRating: UILabel!
    @IBOutlet weak var selectedRuntime: UILabel!
    @IBOutlet weak var selectedOverview: UILabel!
    
    var selectedManager = SelectedManager()
    
    var type: String?
    var selectedId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedManager.delegate = self
        
        selectedManager.getSelectedOptionDetails(type: type!, for: selectedId!)
        
        // Do any additional setup after loading the view.
    }
    
}

extension SelectedViewController: SelectedManagerDelegate {
    
    func didGetSelectedOptionDetails(selected: Selected) {
        DispatchQueue.main.async {
            self.selectedTitle.text = selected.title
            self.selectedReleaseDate.text = selected.releaseDate
            self.selectedRating.text = "\(selected.ratingAverage)(\(selected.ratingCount))"
            self.selectedRuntime.text = "\(selected.runtime)min"
            self.selectedOverview.text = selected.overview
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(selected.image)") {
                if let data = try? Data(contentsOf: url)
                {
                    self.selectedImage.image = UIImage(data: data)
                }
            }
        }
    }
    
}
