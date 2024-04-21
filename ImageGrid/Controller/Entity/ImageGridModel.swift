//
//  ImageGridModel.swift
//  ImageGrid
//
//  Created by Manick on 15/04/24.
//

import Foundation


struct ImageGridModel : Codable{
    let id : String
    let title : String
    let lanuguage : String?
    let thumbnail : ImageThumbnail?
    let mediaType : Int
    let coverageURL : String
    let publishedAt : String
    let publishedBy : String
}

struct ImageThumbnail : Codable{
    let id : String
    let key : String
    let basePath : String
    let domain : String
    let version : Int
    let aspectRatio : Int
    let qualities : [Int]?
}
