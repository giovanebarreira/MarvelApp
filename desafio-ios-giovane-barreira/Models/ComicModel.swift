//
//  ComicModel.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

struct DataResponseComic: Decodable {
    let dataComics: ResultsComics
}

struct ResultsComics: Decodable {
    let resultsComics: [ComicBook]
}

struct ComicBook: Decodable {
    let title: String
    let description: String
    let thumbnail: Thumbnail
    let price: ComicPrice
}

struct ThumbnailComicBook: Decodable {
    let path: String
    let imgExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case imgExtension = "extension"
    }
}

struct ComicPrice: Decodable {
    let type: String
    let price: Float
}
