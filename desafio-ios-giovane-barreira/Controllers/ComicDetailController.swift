//
//  ComicDetailController.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import UIKit

protocol ComicDetailControllerDelegate {
    var characterId: String { get }
}

class ComicDetailController: UIViewController {
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicDescription: UILabel!
    @IBOutlet weak var comicPrice: UILabel!
    @IBOutlet weak var comicView: UIView!
    
    private var comicBookListVM: ComicBookDetailsViewModel!
    var comicDelegate: ComicDetailControllerDelegate?
    let comicClient = ComicsClient()
//    var comicAndPriceDict = [String : Float]()
  //  var greatest: (key: String, value: Float)?
    var mostExpensiveComic: ComicBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestComicsOfSelectedCharacter()
        setupLayout()
    }
    
    func requestComicsOfSelectedCharacter() {
        comicClient.getFeed(from: .comicsOfSelectedCharacter(comicDelegate!.characterId)) { [weak self] result in
            
            switch result {
            case .success(let comicsFeedResult):
                guard let comicResults = comicsFeedResult?.data.results else { return }
                self!.getComicMostExpensive(comics: comicResults)
                
            case .failure(let error):
                print(" error \(error)")
            }
        }
    }
    
    func getComicMostExpensive(comics: [ComicBook]) {
        var mostExpensive: Float = 0.0
        
        for comic in comics {
            if mostExpensive <= (comic.prices[0].price) {
                mostExpensive = (comic.prices[0].price)
                print("mostExpensive \(mostExpensive)")
 
                comicBookListVM = ComicBookDetailsViewModel(comic)
                
                print(comic.thumbnail)
                comicImage.download(image: comicBookListVM.thumbnail)
                comicTitle.text = "Comic Title: \(comic.title)"
                comicDescription.text = "Description: \(comic.description)"
                comicPrice.text = "Price USD: \(comic.prices[0].price)"
            }
        }
    }
    
    func setupLayout() {
        comicView.layer.cornerRadius = 15
    }
}

