//
//  CharacterListViewModel.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

///Getting all characters
struct CharactersListViewModel {
    let characters: [Character]
    
    var numberOfSections: Int {
        return 1
    }
  
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.characters.count
    }
    
    func charactersAtIndex(_ index: Int) -> CharactersViewModel {
        let character = self.characters[index]
        return CharactersViewModel(character)
    }
}

///Getting single data parsed
struct CharactersViewModel {
    private let character: Character
    
    init(_ character: Character) {
        self.character = character
    }
    
    var id: Int {
        return self.character.id
    }
    
    var name: String {
        return self.character.name
    }
    
    var description: String {
        return self.character.description
    }
    
    var thumbnail: String {
        let path = character.thumbnail.path
        let imgExtension = character.thumbnail.imgExtension
        let completeImgPath = "\(path).\(imgExtension)"
        return completeImgPath
    }
}


