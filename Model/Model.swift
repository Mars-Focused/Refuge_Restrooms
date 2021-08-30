//
//  Model.swift
//  An App
//
//  Created by Rave Bizz on 8/29/21.
//

import Foundation

struct Restrooms: Codable {
    var name : String
    var street : String
    var city : String
    var state : String
    var unisex : Bool
    var accessible : Bool
    var downvote : Int
    var upvote : Int
}
