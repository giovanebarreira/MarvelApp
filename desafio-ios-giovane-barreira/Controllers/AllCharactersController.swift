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
    let charactersClient = CharactersClient()
    var currentLimit : Int = 20
    var isLoadingList : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewAndCell()
        newRequest()
    }
    
    func newRequest(){
        charactersClient.getFeed(from:.allCharacters) { [weak self] result in
            
            switch result {
            case .success(let charactersFeedResult):
                guard let characterResults = charactersFeedResult?.data.characterResults else { return }
                self?.characterListVM = CharactersListViewModel(characters: characterResults)
                
                DispatchQueue.main.async {
                    self?.charactersTableView.reloadData()
                }
                
            case .failure(let error):
                print("the error \(error)")
            }
        }
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
        
        self.charactersTableView.separatorInset = .zero
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){

            charactersTableView.reloadData()
          }
    }
}

extension AllCharactersController: CharacterDetailsControllerDelegate {
    func setupDetails(indexPath: Int, character: CharactersListViewModel) {
    }
}

