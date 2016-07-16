//
//  Urls.swift
//  TipBitz
//
//  Created by Rafat Touqir Rafsun on 3/15/16.
//  Copyright © 2016 Rafat Touqir Rafsun. All rights reserved.
//

import UIKit

struct Urls{
    

    static let API_KEY = "4df263f48a4fe2621749627f5d001bf0"
    
    private static let URL_BASE = "https://api.themoviedb.org/3/movie"
    
    static let URL_IMAGE_BASE = "https://image.tmdb.org/t/p/w500"
    
    static let URL_NOW_PLAYING = URL_BASE + "/now_playing"
    static let URL_UPCOMING = URL_BASE + "/upcoming"
    static let URL_TOP_RATED = URL_BASE + "/top_rated"
    
    static func URL_SIMILAR_MOVIES (movieID:String) ->String{
        return "\(URL_BASE)/\(movieID)/similar"
    }
    static func URL_INDIVIDUAL_MOVIES (movieID:String) ->String{
        return "\(URL_BASE)/\(movieID)"
    }
    
    
}
