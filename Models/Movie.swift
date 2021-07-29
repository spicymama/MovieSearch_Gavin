//
//  Movie.swift
//  MovieSearch_2.0
//
//  Created by Gavin Woffinden on 5/9/21.
//

import Foundation
import UIKit

struct MovieTopLevel: Decodable {
    
    let results: [Movie]

}


struct Movie: Decodable {
    let title: String
    let description: String
    let posterURL: String?
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "overview"
        case posterURL = "poster_path"
        case rating = "vote_average"
        
    }
}
// I JUST DONT KNOW WHERE IM GOING WRONG




// gosh dang
