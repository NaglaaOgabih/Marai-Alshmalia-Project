//
//  MainPageViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 18/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import NVActivityIndicatorView
import SideMenu
import Localize_Swift
class MainPageViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var mainTabelView: UITableView!
    @IBOutlet weak var sideMenuBtn: UIButton!
    
    @IBOutlet weak var searchBtn: UIButton!
    var sliderArray : [String] = []
    var secData : [Section] = []
    var settings = SideMenuSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mainTabelView.separatorStyle = .none
        
        mainApi()
//        setupSideMenu()
        sliderCollectionView.reloadData()
    }
    
    @IBAction func sideMenuBtnPressed(_ sender: Any) {
        
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        menu.presentationStyle = .viewSlideOutMenuIn
        if Localize.currentLanguage() == "ar"{
            menu.leftSide = false
        }else if Localize.currentLanguage() == "en"{
            menu.leftSide = true
        }
        present(menu, animated: true, completion: nil)
    }
    func mainApi(){
        Request.startAnimating(view: self.view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar"]
        
        Request.req(url: URLs.main, headers: headers, params: params, meth: .get) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                Request.stopAnimating(view: self.view)
                
                do {
                    let mainDataDecoded = try decoder.decode(MainData.self, from: data)
                    Request.stopAnimating(view: self.view)
                    switch mainDataDecoded.key {
                    case "success":
                        self.sliderArray = mainDataDecoded.data.slider
                        self.secData = mainDataDecoded.data.sections
                        DispatchQueue.main.async {
                            self.sliderCollectionView.reloadData()
                            self.mainTabelView.reloadData()
                        }
                    default:
                        print(error!)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        print(errorValue.msg as Any)
                    }
                } catch {
                    print(error)
                }
                
            }
        }
        
    }
//    private func setupSideMenu() {
//        SideMenuManager.default.rightMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
//    }
}
extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
        let imgUrl = sliderArray[indexPath.row]
        cell.imgView.kf.setImage(with: URL(string: imgUrl))
        cell.pageSlider.numberOfPages = sliderArray.count
        cell.pageSlider.currentPage = indexPath.row
        func prepareForReuse() {
            cell.imgView.image = nil
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sliderCollectionView.frame.size
        
    }
}
extension MainPageViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.delegate = self
        cell.setDataToView(model: self.secData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}

extension MainPageViewController : ItemSelectedDelegate{
    func itemSelectedWith(id: Int) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
        vc?.ids = id
        self.tabBarController?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

