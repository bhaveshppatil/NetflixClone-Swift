//
//  MovieModel.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 23/02/22.
//

import UIKit

struct ResponseTrenfingMovies  : Codable{
    let results : [Movie]
    
}

struct Movie : Codable {
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
 adult = 0;
 "backdrop_path" = "/lqGqvmqHr8T2Ll8w7mzAtNshUpb.jpg";
 "genre_ids" =             (
     28,
     80,
     18
 );
 id = 414906;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "The Batman";
 overview = "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.";
 popularity = "354.448";
 "poster_path" = "/3VFI3zbuNhXzx7dIbYdmvBLekyB.jpg";
 "release_date" = "2022-03-01";
 title = "The Batman";
 video = 0;
 "vote_average" = 0;
 "vote_count" = 0;
},
     {
 "backdrop_path" = "/ctxm191q5o3axFzQsvNPlbKoSYv.jpg";
 "first_air_date" = "2022-01-13";
 "genre_ids" =             (
     10759,
     10765,
     18
 );
 id = 110492;
 "media_type" = tv;
 name = Peacemaker;
 "origin_country" =             (
     US
 );
 "original_language" = en;
 "original_name" = Peacemaker;
 overview = "The continuing story of Peacemaker \U2013 a compellingly vainglorious man who believes in peace at any cost, no matter how many people he has to kill to get it \U2013 in the aftermath of the events of \U201cThe Suicide Squad.\U201d";
 popularity = "2108.722";
 "poster_path" = "/hE3LRZAY84fG19a18pzpkZERjTE.jpg";
 "vote_average" = "8.6";
 "vote_count" = 1165;
},
 */
