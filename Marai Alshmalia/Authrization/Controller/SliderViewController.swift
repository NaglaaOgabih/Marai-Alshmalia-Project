//
//  ViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 06/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SliderViewController: UIViewController {
    

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var introSliders:[introData] = []
    var curentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sliderCollectionView.reloadData()
        IntroAPI()
        self.sliderCollectionView.reloadData()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func SignUpBtnPressed(_ sender: Any) {


    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

    
    
    
    func IntroAPI() {
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar"]
        let method : HTTPMethod = .get
        
        
        Request.req(url: URLs.intro, headers: headers, params: params, meth: method, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    let intro = try decoder.decode(Welcome.self, from: data)
//                    print(data)
                    
                    switch intro.key {
                    case "success":
                        self.introSliders = intro.data
                        DispatchQueue.main.async {
                            self.sliderCollectionView.reloadData()
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
            
        )}
    
}

extension SliderViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introSliders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroCell
//        cell.imgIntro.contentMode = .scaleAspectFill
        cell.imgIntro.kf.indicatorType = .activity
        let imgUrl = introSliders[indexPath.row].image
        cell.imgIntro.kf.setImage(with: URL(string: imgUrl!), placeholder: nil, options: nil)
        cell.descLabel.text = introSliders[indexPath.row].desc
        cell.pageView.numberOfPages = introSliders.count
        cell.prevButton.layer.cornerRadius = 15
        cell.pageView.currentPage = indexPath.row
        if indexPath.row == introSliders.count - 1 {
            cell.prevButton.isHidden = true
            cell.nextButton.isHidden = true
        }else{
            cell.logIn.isHidden = true
            cell.asGuest.isHidden = true
        }

        
        cell.nextAction = {
            self.sliderCollectionView.scrollToItem(at: IndexPath(item: indexPath.row + 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        cell.skipAction = {
            self.sliderCollectionView.scrollToItem(at: IndexPath(item: self.introSliders.count - 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sliderCollectionView.frame.size
    }

    
}

