//
//  TableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 18/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

protocol ItemSelectedDelegate {
    func itemSelectedWith(id : Int)
}
class MainTableViewCell: UITableViewCell{
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var productsName: UILabel!
    
    @IBOutlet weak var viewAllBtn: UIButton!
    var data : [Product] = []
    var delegate: ItemSelectedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        let attributedTitle = NSAttributedString(string: NSLocalizedString("View All", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
        viewAllBtn.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func setDataToView(model:Section) {
        productsName.text = model.sectionName
        data = model.products
        mainCollectionView.reloadData()
        
    }
    
}
extension MainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        cell.cellData(data: data, indexPath: indexPath, cell: cell)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 148, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.itemSelectedWith(id: data[indexPath.row].id)
    }
}
