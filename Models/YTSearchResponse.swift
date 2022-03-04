//
//  YTSearchResponse.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 03/03/22.
//

import Foundation

struct YTSearchResponse : Codable{
    let items : [VideoData]
}

struct VideoData : Codable{
    let  id : VideoID
}

struct VideoID : Codable{
    let kind: String
    let videoId: String
}


