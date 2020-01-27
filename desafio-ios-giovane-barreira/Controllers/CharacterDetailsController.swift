//
//  CharacterDetailsController.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import UIKit

protocol CharacterDetailsControllerDelegate {
    func setupDetails(indexPath: Int, character: CharactersListViewModel)
}

class CharacterDetailsController: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    var delegate:CharacterDetailsControllerDelegate!
    var characterID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupDetails(indexPath: Int, character: CharactersListViewModel) {
        
        let selectedCharacter = character.charactersAtIndex(indexPath)        
        characterName.text = selectedCharacter.name
        characterImage.download(image: selectedCharacter.thumbnail)
        characterDescription.text = selectedCharacter.description
        characterID = selectedCharacter.id
    }
    
    
    @IBAction func showHQBtnTapped(_ sender: Any) {
        guard let navigation = self.navigationController else {
            fatalError("Navigation controller not found")
        }
        
        let detailComics = ComicDetailController(nibName: "ComicDetailController", bundle: nil)
        detailComics.comicDelegate = self
        detailComics.title = "Character Details"
       
        DispatchQueue.main.async {
            detailComics.httpRequestComics(id: self.characterID)
        }
        
        navigation.pushViewController(detailComics, animated: true)
    }
}

extension CharacterDetailsController: ComicDetailControllerDelegate {
    func httpRequestComics(id: Int) {
        characterID = id
    }
}

