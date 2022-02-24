//
//  PopularMovies.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 24/02/22.
//

import UIKit

struct ResponsePopularMovies  : Codable{
    let results : [PopularMovie]
}

struct PopularMovie : Codable {
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

/*
 results =     (
             {
         "backdrop_path" = "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg";
         "first_air_date" = "2019-06-16";
         "genre_ids" =             (
             18
         );
         id = 85552;
         "media_type" = tv;
         name = Euphoria;
         "origin_country" =             (
             US
         );
         "original_language" = en;
         "original_name" = Euphoria;
         overview = "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.";
         popularity = "5452.129";
         "poster_path" = "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg";
         "vote_average" = "8.4";
         "vote_count" = 6930;
     },
 */

