//
//  CharactersModel.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

struct CharacterDataResponse: Decodable {
    let data: CharactersResult
}

struct CharactersResult: Decodable {
    let characterResults: [Character]
    
    enum CodingKeys: String, CodingKey {
        case characterResults = "results"
    }
}

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Decodable {
    let path: String
    let imgExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case imgExtension = "extension"
    }
}



