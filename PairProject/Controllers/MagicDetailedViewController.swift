//
//  MagicDetailedViewController.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import UIKit

class MagicDetailedViewController: UIViewController {

    
    @IBOutlet weak var magicDetailedCollectionView: UICollectionView!
    
    var magicCard = [foreignNamesWrapper]()
    var magicCardImage: MagicCard.CardWrapper!
    override func viewDidLoad() {
        super.viewDidLoad()
        magicDetailedCollectionView.dataSource = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goBack))
        view.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
   

}
extension MagicDetailedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var urlString = ""
        guard let cell = magicDetailedCollectionView.dequeueReusableCell(withReuseIdentifier: "MagicDetailedCell", for: indexPath) as? MagicDetailedCell else {return UICollectionViewCell()}
        let cardToSet = magicCard[indexPath.row]
        cell.magicNameLabel.text = cardToSet.name
        cell.magicLanguageLabel.text = cardToSet.language
        cell.magicDesciptionText.text = cardToSet.text
        cell.magicDetailedActivityIndicator.startAnimating()
        let imageUrl = cardToSet.imageUrl
        urlString = imageUrl.absoluteString
        if let image = ImageHelper.shared.image(forKey: imageUrl.absoluteString as NSString) {
                cell.magicDetailedImage.image = image
                cell.magicDetailedActivityIndicator.stopAnimating()
            } else {
                ImageHelper.shared.fetchImage(urlString: urlString) { (appError, image) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        if urlString == imageUrl.absoluteString {
                            cell.magicDetailedImage.image = image
                            cell.magicDetailedActivityIndicator.stopAnimating()
                        }
                    }
                }                
        }
        return cell
    }
    
    
}
