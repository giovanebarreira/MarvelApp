//
//  ComicBookDetailsViewModel.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 1/26/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

///Getting single data parsed
struct ComicBookDetailsViewModel {
    
    private let comicBook: ComicBook
    
    init(_ comicBook: ComicBook) {
        self.comicBook = comicBook
    }
    
    var title: String {
        return self.comicBook.title
    }
    
    var description: String {
        return self.comicBook.description!
    }

    var printedComicPrice: [Float] {
        return self.printedComicPrice
    }

    
    var thumbnail: String {
        let path = comicBook.thumbnail.path
        let imgExtension = comicBook.thumbnail.imgExtension
        let completeImgPath = "\(path).\(imgExtension)"
        return completeImgPath
    }

}


