//
//  ViewController.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {
    var filterHaveImages = [MagicCard.CardWrapper]()
    var magicCards = [MagicCard.CardWrapper](){
        didSet{
            DispatchQueue.main.async {
                self.magicCollectionView.reloadData()
                self.filterHaveImages = self.magicCards.filter {$0.imageUrl != nil}
            }
        }
    }
   
    @IBOutlet weak var magicCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        magicCollectionView.dataSource = self
        magicCollectionView.delegate = self
        CardsAPI.getMagicCards { (appError, magicCards) in
            if let appError = appError{
                print(appError.errorMessage())
            } else if let magicCards = magicCards{
                self.magicCards = magicCards
            }
        }
    }
    
    
}
extension MagicViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterHaveImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var urlString = ""
        
        let imageToSet = filterHaveImages[indexPath.row]
        guard let cell = magicCollectionView.dequeueReusableCell(withReuseIdentifier: "MagicCell", for: indexPath) as? MagicCell else {return UICollectionViewCell()}
        cell.magicActivityIndicator.startAnimating()
        if let imageUrl = imageToSet.imageUrl{
            urlString = imageUrl.absoluteString
            if let image = ImageHelper.shared.image(forKey: imageUrl.absoluteString as NSString) {
                
                cell.magicImage.image = image
                cell.magicActivityIndicator.stopAnimating()
            } else {
                
                ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        if urlString == imageUrl.absoluteString {
                            cell.magicImage.image = image
                            cell.magicActivityIndicator.stopAnimating()
                        }
                    }
                    
                }
            }
        }
        
       return cell
    }
}
extension MagicViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:125, height:175)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "magicDetail") as? MagicDetailedViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.magicCard = filterHaveImages[indexPath.row].foreignNames
        vc.magicCardImage = filterHaveImages[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}
