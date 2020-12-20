//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Kirill Sidelkovsky on 26.10.2020.
//  Copyright © 2020 sidelkovsky.com. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    
    @IBAction func createMeme(_ sender: Any) {
        
        presentMemeCreator()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeDataStore.shared.getMemes().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell",for: indexPath) as! MemeCollectionCell
        
        let item = MemeDataStore.shared.getMemes()[indexPath.row]

        cell.imageView?.image = item.memedImage

        return cell
        
        
    }
    
}
