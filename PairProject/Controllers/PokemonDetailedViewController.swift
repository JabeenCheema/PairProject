//
//  PokemonDetailedViewController.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class PokemonDetailedViewController: UIViewController {

    var pokemonCard: PokemonCard.PokemonCardWrapper!
    var pokemonDetail = [Attacks]()
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDetailedCollectionView: UICollectionView!
    @IBOutlet weak var pokemonActivityIndicator: UIActivityIndicatorView!
   
    override func viewDidLoad() {
        pokemonDetailedCollectionView.dataSource = self
        super.viewDidLoad()
        updateUI()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goBack))
        view.addGestureRecognizer(tap)
    }
    
    func updateUI(){
        if let imageHiRes = pokemonCard.imageUrlHiRes{
            pokemonActivityIndicator.startAnimating()
            if let image = ImageHelper.shared.image(forKey: imageHiRes as NSString){ // this is for when we scroll fast 51-62
                pokemonImage.image = image
            } else {
                ImageHelper.shared.fetchImage(urlString: imageHiRes) { (appError, image) in
                    if let appError = appError{
                        print(appError.errorMessage())
                    } else if let image = image {
                    
                        self.pokemonImage.image = image
                        self.pokemonActivityIndicator.stopAnimating()
                    }
                    
                }
            }
        }
    }
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }

}

extension PokemonDetailedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let attackToSet = pokemonDetail[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonDetailedCell", for: indexPath) as? PokemonDetailedCell else {return UICollectionViewCell()}
        cell.pokemonAttackNameLabel.text = attackToSet.name
        cell.pokemonAttackDamageLabel.text = attackToSet.damage
        if attackToSet.text == ""{
            cell.pokemonAttackText.isHidden = true
        } else {
            cell.pokemonAttackText.text = attackToSet.text
        }
        return cell
    }
}


