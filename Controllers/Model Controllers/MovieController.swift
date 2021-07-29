//
//  MovieController.swift
//  MovieSearch_2.0
//
//  Created by Gavin Woffinden on 5/9/21.
//

import UIKit

class MovieController {
    
   //https://api.themoviedb.org/3/search/movie/?api_key=24701c2db5555d999cf147b3445a971e&query=jaws
    
    
    //MARK: -  String Constants
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    static let apiKeyKey = "api_key"
    static let apiKeyValue = "24701c2db5555d999cf147b3445a971e"
    static let queryComponent = "query"
    static let posterImageURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    //MARK: - Functions
    static func fetchMovies(searchTerm: String, completion: @escaping (Result<[Movie], NetworkError>)-> Void) {
        
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
       
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKeyKey, value: apiKeyValue)
        let searchQuery = URLQueryItem(name: queryComponent, value: searchTerm)
        components?.queryItems = [apiQuery, searchQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
      //  var components2 = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
      //  let searchQuery = URLQueryItem(name: queryComponent, value: searchTerm)
      //  components2?.queryItems = [searchQuery]
        
      //  guard let finalURL = components2?.url else {return completion(.failure(.invalidURL))}
        
        
        print(finalURL)

        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("MOVIE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let movieTop = try JSONDecoder().decode(MovieTopLevel.self, from: data)
                let movieDetails = movieTop.results
               
                completion(.success(movieDetails))
                
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchPoster(for movie: Movie, completion: @escaping (Result<UIImage, NetworkError>)-> Void) {
        
        //guard let imageURL = URL(string: movie.posterURL) else {return}
        
        guard let posterImageURL = posterImageURL else {return completion(.failure(.invalidURL))}
        print(posterImageURL)
        guard let poster = movie.posterURL else {return}
        let imageURL = posterImageURL.appendingPathComponent(poster)
        print(imageURL)
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POSTER STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let poster = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(poster))
        }.resume()
    }
}//End of class
