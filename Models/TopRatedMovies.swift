//
//  TopRatedMovies.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 24/02/22.
//

import UIKit

struct ResponseTopRatedMovies  : Codable{
    let results : [TopRatedMovie]
}

struct TopRatedMovie : Codable {
    let id : Int
    let media_type :String?
    let original_language  : String?
    let original_title : String?
    let overview : String?
    let poster_path : String?
    let vote_count : Int
    let release_date : String?
    let backdrop_path : String?
}
