//
//	RootClass.swift
//
//	Create by Rafat Touqir Rafsun on 16/7/2016
//	Copyright © 2016. All rights reserved.
//

import UIKit


struct Movie{

	var adult : Bool?
	var backdropPath : String?
	var genreIds : [Int]?
	var id : Int?
	var originalLanguage : String?
	var originalTitle : String?
	var overview : String?
	var popularity : Float?
	var posterPath : String?
	var releaseDate : String?
	var title : String?
	var video : Bool?
	var voteAverage : Float?
	var voteCount : Int?


	/**
	 * Instantiate the instance using the passed json s to set the properties s
	 */
	init(fromJson json: JSON){
		if json == nil{
			return
		}
		adult = json["adult"].bool
		backdropPath = json["backdrop_path"].string
		if let genreIdsArray = json["genre_ids"].array{
			genreIds = [Int]()
			for genreIdsJson in genreIdsArray{
                if let genreId = genreIdsJson.int{
                    genreIds?.append(genreId)
                }
			}
        }
        
        id = json["id"].int
		originalLanguage = json["original_language"].string
		originalTitle = json["original_title"].string
		overview = json["overview"].string
		popularity = json["popularity"].float
		posterPath = json["poster_path"].string
		releaseDate = json["release_date"].string
		title = json["title"].string
		video = json["video"].bool
		voteAverage = json["vote_average"].float
		voteCount = json["vote_count"].int
	}

}