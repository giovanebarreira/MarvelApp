//
//  WebService.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

class WebService {
    func getCharacters(url: URL, completion: @escaping ([Character]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let charactersList = try? JSONDecoder().decode(DataResponse.self, from: data)
                
                if let charactersList = charactersList {
                    completion(charactersList.data.results)
                }
            }
        }.resume()
    }
    
  func performRequest(urlString: String) {
       //Create a URL
       if let url = URL(string: urlString) {
           //URL session
           let session = URLSession(configuration: .default)
           //Giving the session a task
           let task = session.dataTask(with: url) { (data, response, error) in
               if let err = error {
                print(err.localizedDescription)
                   return
               }
               //Convert Data type to String
               if let safeData = data {
                 let comicsList = try? JSONDecoder().decode(DataResponseComic.self, from: safeData)
                 print(comicsList)
               }
           
        
           }
           //Start the task
           task.resume()
       }
   }
    
}
