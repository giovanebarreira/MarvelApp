//
//  Result.swift
//  desafio-ios-giovane-barreira
//
//  Created by Giovane Barreira on 2/1/20.
//  Copyright © 2020 Giovane Barreira. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
