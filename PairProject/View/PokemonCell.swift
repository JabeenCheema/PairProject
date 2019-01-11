//
//  PokemonCell.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
@IBOutlet weak var pokemonImage: UIImageView!
@IBOutlet weak var pokemonActivityIndicator: UIActivityIndicatorView!

//public var urlString = ""
//    
//    public func configureCell(pokemon: PokemonCard.PokemonCardWrapper) {
//        let haveImages = [PokemonCard.PokemonCardWrapper]()
//
//        urlString = pokemon.imageURL?.absoluteString
//        if let image = ImageHelper.shared.image(forKey: (pokemon.imageURL?.absoluteString)! as NSString) {
//            pokemonImage.image = image
//        } else {
//            pokemonActivityIndicator.startAnimating()
//            ImageHelper.shared.fetchImage(urlString: (pokemon.imageURL?.absoluteString)!) { (appError, image) in
//                if let appError = appError {
//                    print(appError.errorMessage())
//                } else if let image = image {
//                    if self.urlString == pokemon.imageURL?.absoluteString {
//                        self.pokemonImage.image = image
//                    }
//                }
//            self.pokemonActivityIndicator.stopAnimating()
//            }
//        }
//    }
}

