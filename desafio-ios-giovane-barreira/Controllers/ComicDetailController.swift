//
//  ComicDetailController.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import UIKit

protocol ComicDetailControllerDelegate {
    func httpRequestComics(id: Int)
}

class ComicDetailController: UIViewController {
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicDescription: UILabel!
    @IBOutlet weak var comicPrice: UILabel!
    
    private var comicBookDetailsVM: ComicsListViewModel!
    var comicDelegate: ComicDetailControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComicbook()
    
    }
    
    func setupComicbook() {
        
    }
    
    func httpRequestComics(id: Int) {
        print(id)
        let url  = "https://gateway.marvel.com:443/v1/public/characters/\(id)/comics?limit=100&ts=1&apikey=f6b3acfaacdefbba53b2fe3cd32fb87e&hash=4d0f627bea35913d20310b6c8ebebbb3"
        
        WebService().performRequest(urlString: url)
    }
    
}
