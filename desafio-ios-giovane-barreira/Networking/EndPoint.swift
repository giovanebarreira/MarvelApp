//
//  EndPoint.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 2/1/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var apiKey: String {
        return "ts=1&apikey=f6b3acfaacdefbba53b2fe3cd32fb87e&hash=4d0f627bea35913d20310b6c8ebebbb3"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum CharactersFeed {
    case allCharacters
    case comicsOfSelectedCharacter(String)
}

extension CharactersFeed: Endpoint {
    
    var base: String {
        return "https://gateway.marvel.com/"
    }
    
    var path: String {
        switch self {
        case .allCharacters:
            return "/v1/public/characters"
        case .comicsOfSelectedCharacter(let characterId):
            return "/v1/public/characters/\(characterId)/comics"
        }

    }
}


