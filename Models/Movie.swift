//
//  Movie.swift
//  MovieSearch_Gavin
//
//  Created by Gavin Woffinden on 5/7/21.
//

//24701c2db5555d999cf147b3445a971e

import Foundation

struct MovieTopLevelObject: Codable {
    let results: Movie

struct Movie: Codable {
    let title: String
    let overview: String
    let vote_average: Double
    let poster_path: URL?
    }
}
