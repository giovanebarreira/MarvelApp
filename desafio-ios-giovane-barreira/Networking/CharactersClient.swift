//
//  Client.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 2/1/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

class CharactersClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getFeed(from dataFeedType: CharactersFeed, completion: @escaping (Result<CharacterDataResponse?, APIError>) -> Void) {
        
        let endpoint = dataFeedType
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> CharacterDataResponse? in
            guard let charactersFeedResult = json as? CharacterDataResponse else { return  nil }
            return charactersFeedResult
        }, completion: completion)
    }
}

