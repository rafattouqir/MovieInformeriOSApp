//
//	ProductionCountry.swift
//
//	Create by Rafat Touqir Rafsun on 16/7/2016
//	Copyright © 2016. All rights reserved.
//

import Foundation


struct ProductionCountry{

	var iso31661 : String?
	var name : String?


	/**
	 * Instantiate the instance using the passed json s to set the properties s
	 */
	init(fromJson json: JSON){
		if json == nil{
			return
		}
		iso31661 = json["iso_3166_1"].string
		name = json["name"].string
	}

}