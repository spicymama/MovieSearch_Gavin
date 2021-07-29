//
//  MovieListTableViewController.swift
//  MovieSearch_2.0
//
//  Created by Gavin Woffinden on 5/9/21.
//


import UIKit


// I only had to fix one word, so I hope it's ok I didn't remake the whole project for my third attempt...



class MovieListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    var movies: [Movie] = []
    var movie: Movie?
    //MARK: -  Functions
    func fetchMoviesForTableview() {
        MovieController.fetchMovies(searchTerm: String()) { (result) in
        
            
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.movies = movie
                    self.tableView.reloadData()
                case .failure(let error):
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        let movie = movies[indexPath.row]
        cell?.movie = movie


        return cell ?? MovieTableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }

}

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        MovieController.fetchMovies(searchTerm: searchTerm.lowercased()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                   // self.fetchMoviesForTableview()
                    self.movies = movie
                    self.tableView.reloadData()
                case .failure(let error):
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
