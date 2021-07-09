//
//  CollectionViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 11/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController{
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
        
    }

    @IBAction func collectionBtnPressed(_ sender: Any) {
        //        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)!.scrollDirection = .vertical
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width/4, height: 118)

    }
    @IBAction func tableBtnPressed(_ sender: Any) {
        //        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)!.scrollDirection = .horizontal
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width, height: 118)

    }

    
}
extension CollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.img.image = UIImage(named: "onii")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item % 3 == 0 {
            return CGSize(width: 200, height: 240)
            
        }
            return CGSize(width: 100, height: 120)
    }
   
}
