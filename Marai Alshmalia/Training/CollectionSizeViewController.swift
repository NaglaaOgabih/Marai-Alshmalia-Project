//
//  CollectionSizeViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 11/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CollectionSizeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var collection: UICollectionView!
    let layout = UICollectionViewFlowLayout()
     var pickedImg : UIImage?
    var pickedImgArray : [UIImage]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collection.reloadData()
        
    }
    @IBAction func collectionBtnPressed(_ sender: Any) {
        layout.scrollDirection = .vertical
        collection.collectionViewLayout = layout
        layout.itemSize = CGSize(width: self.collection.frame.size.width/4, height: 118)

    }

    @IBAction func tableBtnPressed(_ sender: Any) {

       let imagePickerController = UIImagePickerController()
             imagePickerController.delegate = self
             let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
             actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
                 imagePickerController.sourceType = .camera
                 self.present(imagePickerController, animated: true, completion: nil)
             }))
             actionSheet.addAction(UIAlertAction(title: "Photo Liperary", style: .default, handler: { (action : UIAlertAction) in
                 imagePickerController.sourceType = .photoLibrary
                 
                 self.present(imagePickerController, animated: true, completion: nil)
                 
             }))
             actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action : UIAlertAction) in
                 //            self.present(imagePickerController, animated: true, completion: nil)
                 
             }))
             self.present(actionSheet, animated: true, completion: nil)
             
             
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            pickedImg = image
            pickedImgArray?.append(image)
        collection.reloadData()

        }
//           imgView.image = image
           picker.dismiss(animated: true, completion: nil)
           
       }
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
           
       }
//
    // MARK: UICollectionViewDataSource
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pickedImgArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.img.image = pickedImgArray?[indexPath.row]
        
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item % 3 == 0 {
//
//            return CGSize(width: 200, height: 240)
//        }
//        return CGSize(width: 100, height: 120)
//    }
    
    
}
