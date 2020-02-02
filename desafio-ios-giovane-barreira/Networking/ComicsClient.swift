//
//  ComicsClient.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 2/1/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

class ComicsClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getFeed(from dataFeedType: CharactersFeed, completion: @escaping (Result<ComicDataResponse?, APIError>) -> Void) {
        
        let endpoint = dataFeedType
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> ComicDataResponse? in
            guard let comicsFeedResult = json as? ComicDataResponse else { return  nil }
            return comicsFeedResult
        }, completion: completion)
    }
}

