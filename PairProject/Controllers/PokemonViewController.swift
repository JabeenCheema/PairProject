//
//  PokemonViewController.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    var pokemonCards = [PokemonCard.PokemonCardWrapper](){
        didSet{
            DispatchQueue.main.async {
                self.pokemonCollectionView.reloadData()
                print(self.pokemonCards.count)
//                self.haveImages = self.pokemonCards.filter {$0.imageURL != nil}
//                print(self.haveImages.count)
            }
        }
    }
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        CardsAPI.getPokemonCards { (appError, pokemonCards) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let pokemonCards = pokemonCards {
                DispatchQueue.main.async {
                    self.pokemonCards = pokemonCards
                }
                
            }
        }
        
    }
    
}

extension PokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var urlString = ""
        let pokemonToSet = pokemonCards[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell else { return UICollectionViewCell()}  // asking the comp for a cell once we have that cell populate it and if we don't find a cell with that name return an empty one
            

        // model has an optional so we still need to check if there's an image
        if let imageUrl = pokemonToSet.imageUrl{  // This return nil
            cell.pokemonActivityIndicator.startAnimating()
            urlString = imageUrl
            if let image = ImageHelper.shared.image(forKey: imageUrl as NSString){ // this is for when we scroll fast 51-62
                cell.pokemonImage.image = image
            } else {
                ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                    if let appError = appError{
                        print(appError.errorMessage())
                    } else if let image = image {
                        if urlString == imageUrl{
                         cell.pokemonImage.image = image
                         cell.pokemonActivityIndicator.stopAnimating()
                        }
                    }
                    
                }
            }
        }
//        cell.configureCell(pokemon: pokemon)
        return cell
    
    }
}
extension PokemonViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 175)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailedVC = storyboard.instantiateViewController(withIdentifier: "pokemonDetail") as? PokemonDetailedViewController else {return}
        detailedVC.modalPresentationStyle = .overCurrentContext
        detailedVC.pokemonCard = pokemonCards[indexPath.row]
        detailedVC.pokemonDetail = pokemonCards[indexPath.row].attacks
        present(detailedVC, animated: true, completion: nil)
    }
}

