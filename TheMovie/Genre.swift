//
//	Genre.swift
//
//	Create by Rafat Touqir Rafsun on 16/7/2016
//	Copyright © 2016. All rights reserved.
//

import Foundation


struct Genre{

	var id : Int?
	var name : String?


	/**
	 * Instantiate the instance using the passed json s to set the properties s
	 */
	init(fromJson json: JSON){
		if json == nil{
			return
		}
		id = json["id"].int
		name = json["name"].string
	}


    
	
}