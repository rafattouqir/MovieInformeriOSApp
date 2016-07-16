//
//	IndividualMovieDetail.swift
//
//	Create by Rafat Touqir Rafsun on 16/7/2016
//	Copyright © 2016. All rights reserved.
//

import Foundation


struct IndividualMovieDetail{

	var adult : Bool?
	var backdropPath : String?
	var belongsToCollection : BelongsToCollection?
	var budget : Int?
	var genres : [Genre]?
	var homepage : String?
	var id : Int?
	var imdbId : String?
	var originalLanguage : String?
	var originalTitle : String?
	var overview : String?
	var popularity : Float?
	var posterPath : String?
	var productionCompanies : [Genre]?
	var productionCountries : [ProductionCountry]?
	var releaseDate : String?
	var revenue : Int?
	var runtime : Int?
	var spokenLanguages : [SpokenLanguage]?
	var status : String?
	var tagline : String?
	var title : String?
	var video : Bool?
	var voteAverage : Int?
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
		let belongsToCollectionJson = json["belongs_to_collection"]
		if belongsToCollectionJson != JSON.null{
			belongsToCollection = BelongsToCollection(fromJson: belongsToCollectionJson)
		}
		budget = json["budget"].int
		if let genresArray = json["genres"].array{
			genres = [Genre]()
			for genresJson in genresArray{
				genres?.append(Genre(fromJson: genresJson))
			}
		}
		homepage = json["homepage"].string
		id = json["id"].int
		imdbId = json["imdb_id"].string
		originalLanguage = json["original_language"].string
		originalTitle = json["original_title"].string
		overview = json["overview"].string
		popularity = json["popularity"].float
		posterPath = json["poster_path"].string
		if let productionCompaniesArray = json["production_companies"].array{
			productionCompanies = [Genre]()
			for productionCompaniesJson in productionCompaniesArray{
				productionCompanies?.append(Genre(fromJson: productionCompaniesJson))
			}
		}
		if let productionCountriesArray = json["production_countries"].array{
			productionCountries = [ProductionCountry]()
			for productionCountriesJson in productionCountriesArray{
				productionCountries?.append(ProductionCountry(fromJson: productionCountriesJson))
			}
		}
		releaseDate = json["release_date"].string
		revenue = json["revenue"].int
		runtime = json["runtime"].int
		if let spokenLanguagesArray = json["spoken_languages"].array{
			spokenLanguages = [SpokenLanguage]()
			for spokenLanguagesJson in spokenLanguagesArray{
				spokenLanguages?.append(SpokenLanguage(fromJson: spokenLanguagesJson))
			}
		}
		status = json["status"].string
		tagline = json["tagline"].string
		title = json["title"].string
		video = json["video"].bool
		voteAverage = json["vote_average"].int
		voteCount = json["vote_count"].int
	}

}