//
//  MovieController.swift
//  MovieSearch_Gavin
//
//  Created by Gavin Woffinden on 5/7/21.
//

import UIKit

class MovieController {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/movie/")
    static let apiKeyKey = "api_key="
    static let apiKeyValue = "24701c2db5555d999cf147b3445a971e"
    static let movieID = "550"
    
    
    static func fetchMovies(completion: @escaping (Result<MovieTopLevelObject, NetworkError>) -> Void) {
        
        guard let baseURL = baseURL else {return}
        let movieURL = baseURL.appendingPathComponent(movieID)
        
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKeyKey, value: apiKeyValue)
        components?.queryItems = [apiQuery]

        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("MOVIE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do{
                let movie = try JSONDecoder().decode(MovieTopLevelObject.self, from: data)
                
                completion(.success(movie))
                
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchMoviePoster(for movie: MovieTopLevelObject, completion: @escaping (Result<UIImage, NetworkError>)-> Void) {
        guard let url = movie.results.poster_path else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("MOVIE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let poster_path = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(poster_path))
            
        }.resume()
    }
}
