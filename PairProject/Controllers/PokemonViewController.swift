//
//  PokemonViewController.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    var pokemonCards = [PokemonCard.CardWrapper](){
        didSet{
            print(pokemonCards.count)
        }
    }
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardsAPI.getPokemonCards { (appError, pokemonCards) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let pokemonCards = pokemonCards {
                self.pokemonCards = pokemonCards
            }
        }
        
    }
    


}
