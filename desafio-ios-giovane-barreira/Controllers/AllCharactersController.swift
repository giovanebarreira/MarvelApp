//
//  AllCharactersController.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation
import UIKit

class AllCharactersController: UIViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    private let identifier = "charCell"
    private var characterListVM: CharactersListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewAndCell()
        httpRequest()
    }
    
    //MARK: Setup TableView
    func setupTableViewAndCell() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        
        //Register cell nib
        charactersTableView.register(UINib(nibName: "AllCharactersCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        //Layout
        if let navigationController = self.navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
        }
    }
    
    func httpRequest() {
        let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?limit=100&ts=1&apikey=f6b3acfaacdefbba53b2fe3cd32fb87e&hash=4d0f627bea35913d20310b6c8ebebbb3")!
        
        WebService().getCharacters(url: url) { characters in
            if let characters = characters {
                self.characterListVM = CharactersListViewModel(characters: characters)
                
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                }
            }
        }
    }
}

extension AllCharactersController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.characterListVM == nil ? 0 : self.characterListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = charactersTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? AllCharactersCell else {
            fatalError("Could not find cell: \(identifier)")
        }
        
        let characterVM = self.characterListVM.charactersAtIndex(indexPath.row)
        
        cell.characterName.text = characterVM.name
        cell.characterImage.download(image: characterVM.thumbnail)
        
        return cell
    }
}

extension AllCharactersController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigation = self.navigationController else {
            fatalError("Navigation controller not found")
        }
        
        let detailCharacters = CharacterDetailsController(nibName: "CharacterDetailsController", bundle: nil)
        detailCharacters.delegate = self
        detailCharacters.title = "Character Details"
        DispatchQueue.main.async {
            detailCharacters.setupDetails(indexPath: indexPath.row, character: self.characterListVM)
        }
        navigation.pushViewController(detailCharacters, animated: true)
    }
}

extension AllCharactersController: CharacterDetailsControllerDelegate {
    func setupDetails(indexPath: Int, character: CharactersListViewModel) {
        print(indexPath)
    }
}
