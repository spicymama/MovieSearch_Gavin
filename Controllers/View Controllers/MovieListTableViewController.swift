//
//  MovieListTableViewController.swift
//  MovieSearch_Gavin
//
//  Created by Gavin Woffinden on 5/7/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {

  
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    // MARK: - Table view data source

    var movies: MovieTopLevelObject?
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results.title.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)


        return cell
    }
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        MovieController.fetchMovies(){ (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.movies = movie
                case .failure(let error):
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
        }
    }
}
}
