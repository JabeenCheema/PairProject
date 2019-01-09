//
//  ViewController.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {
    
    var magicCards = [MagicCard.CardWrapper](){
        didSet{
            print(magicCards.count)
        }
    }
   
    @IBOutlet weak var magicCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardsAPI.getMagicCards { (appError, magicCards) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let magicCards = magicCards{
                self.magicCards = magicCards
            }
        }
    }
    
    
}

