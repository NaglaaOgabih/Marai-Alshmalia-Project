//
//  ProductViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 20/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Cosmos
import iOSDropDown
import Alamofire
class ProductViewController: UIViewController {
    var productArray : SelectedData?
    var slaughteredSelected : Bool = true
    var aliveSelected : Bool = false
    var normalSelected : Bool = true
    var charitySelected : Bool = false

    var amountCounterCalculate = 0
    var meetCounterCalculate = 0
    var productNameArray: [String] = []
    var productIdArray: [Int] = []
    var cutsNameArray : [String] = []
    var cutsIdArray : [Int] = []
    var encapsulationsNameArray : [String] = []
    var encapsulationsIdArray : [Int] = []
    var headsNameArray : [String] = []
    var headsIdArray : [Int] = []
    var charitiesNameArray : [String] = []
    var charitiesIdArray : [Int] = []
    var favProduct : Bool = false
    var orderType : String = "normal"
    var itemType : String = "slaughtered"
    var sizeCurrntIndex : Int?
    var slaughterCurrntIndex : Int?
    var coveringCurrntIndex : Int?
    var headCurrntIndex : Int?
    var charitiyCurrntIndex : Int?
    var validation = Validation()
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var starsRate: CosmosView!
    @IBOutlet weak var txtRate: UILabel!
    @IBOutlet weak var descTxt: UILabel!
    @IBOutlet weak var normalReqBtn: UIButton!
    @IBOutlet weak var charityReqBtn: UIButton!
    @IBOutlet weak var slaughteredBtn: UIButton!
    @IBOutlet weak var aliveBtn: UIButton!
    var ids: Int?
    @IBOutlet weak var amountTxtField: UILabel!
    @IBOutlet weak var sizeDropDown: DropDown!
    @IBOutlet weak var slaughteredDropDown: DropDown!
    @IBOutlet weak var coveringDropDown: DropDown!
    @IBOutlet weak var headDropDown: DropDown!
    @IBOutlet weak var meetPlusButtom: UIButton!
    @IBOutlet weak var meetMinusButtom: UIButton!
    @IBOutlet weak var meetAmountCounter: UILabel!
    @IBOutlet weak var notesTxtField: UITextField!
    @IBOutlet weak var choiseStackHidden: UIStackView!
    @IBOutlet weak var charitiesTxt: UILabel!
    @IBOutlet weak var charitiesDropDown: DropDown!
    @IBOutlet weak var favBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.starsRate.settings.updateOnTouch = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2099409997, green: 0.2199924588, blue: 0.2154181302, alpha: 1)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        slaughteredBtn.setImage(UIImage(named: "checkon"), for: .normal)
        mainApi()
        normalReqBtnCall()
        print(AppConstant.Token)
    }
    
    @IBAction func normalReqBtnPressed(_ sender: Any) {
        normalReqBtnCall()
        orderType = "normal"
        amountCounterCalculate = 0
        amountTxtField.text = String(amountCounterCalculate)
        meetCounterCalculate = 0
        meetAmountCounter.text = String(meetCounterCalculate)
        
    }
    @IBAction func charityReqBtnPressed(_ sender: Any) {
        charityReqBtn.backgroundColor = .darkGray
        charityReqBtn.setTitleColor(UIColor(red: 255, green: 249, blue: 232, alpha: 1), for: .normal)
        normalReqBtn.backgroundColor = UIColor(red: 255, green: 249, blue: 232, alpha: 1)
        normalReqBtn.setTitleColor(.darkGray, for: .normal)
        
        charitiesTxt.isHidden = false
        charitiesDropDown.isHidden = false
        orderType = "sadaqah"
        amountCounterCalculate = 0
        amountTxtField.text = String(amountCounterCalculate)
        meetCounterCalculate = 0
        meetAmountCounter.text = String(meetCounterCalculate)
        
    }
    @IBAction func slaughteredBtnPressed(_ sender: Any) {
        amountCounterCalculate = 0
        amountTxtField.text = String(amountCounterCalculate)
        meetCounterCalculate = 0
        meetAmountCounter.text = String(meetCounterCalculate)
        itemType = "slaughtered"
        slaughteredSelected = true
        aliveSelected = false
        slaughteredBtn.setImage(UIImage(named: "checkon"), for: .normal)
        aliveBtn.setImage(UIImage(named: "checkoff"), for: .normal)
        choiseStackHidden.isHidden = false
        slaughteredSelected = !slaughteredSelected
        
    }
    @IBAction func aliveBtnPressed(_ sender: Any) {
        amountCounterCalculate = 0
        amountTxtField.text = String(amountCounterCalculate)
        meetCounterCalculate = 0
        meetAmountCounter.text = String(meetCounterCalculate)
        itemType = "alive"
        aliveSelected = true
        slaughteredSelected = false
        aliveBtn.setImage(UIImage(named: "checkon"), for: .normal)
        slaughteredBtn.setImage(UIImage(named: "checkoff"), for: .normal)
        choiseStackHidden.isHidden = true
        aliveSelected = !aliveSelected
    }
    @IBAction func plusCountBtnPressed(_ sender: Any) {
        amountCounterCalculate += 1
        amountTxtField.text = String(amountCounterCalculate)
    }
    @IBAction func minusCountBtnPressed(_ sender: Any) {
        if amountCounterCalculate != 0 {
            amountCounterCalculate -= 1
            amountTxtField.text = String(amountCounterCalculate)
        }
    }
    @IBAction func plusMeetBtnPressed(_ sender: Any) {
        meetCounterCalculate += 1
        meetAmountCounter.text = String(meetCounterCalculate)
    }
    @IBAction func minusMeetBtnPressed(_ sender: Any) {
        if meetCounterCalculate != 0 {
            meetCounterCalculate -= 1
            meetAmountCounter.text = String(meetCounterCalculate)
        }
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        postMainApi()
    }
    
    @IBAction func favBtnPressed(_ sender: Any) {
        if AppConstant.isLoggedIn == true {
            if productArray?.isFav == true {
                toggleWith(isFav: false )
            } else {
                toggleWith(isFav: true )
            }
            
        } else {
            
        }
        
    }
    
    func toggleWith(isFav:Bool){
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar", "ApiToken": AppConstant.Token ?? "" ]
        Request.req(url: URLs.toggleFav, headers: headers, params: params, meth: .get, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    
                    let decodedData = try decoder.decode(UpdatePass.self, from: data)
                    switch decodedData.key {
                    case "success":
                        if isFav == true{
                            self.favBtn.setImage(UIImage(named: "heart (5)"), for: .normal)
                            self.productArray?.isFav = true
                        }else{
                            self.favBtn.setImage(UIImage(named: "favproduct"), for: .normal)
                            self.productArray?.isFav = false
                        }
                    default:
                        print(error?.localizedDescription)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        print(errorValue.msg as Any)
                    }
                } catch {
                    print(error)
                }
                
            }
        }
            
        )}
    
    
    func mainApi(){
        Request.startAnimating(view: self.view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: "\(URLs.showProduct)/\(ids ?? 0)" , headers: headers, params: params, meth: .get) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    let productDataDecoded = try decoder.decode(SelectedItemData.self, from: data)
                    Request.stopAnimating(view: self.view)
                    switch productDataDecoded.key {
                    case "success":
                        self.productArray = productDataDecoded.data
                        self.setReqData()
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
    func postMainApi(){
        let decoder = JSONDecoder()
        if self.check() == true{
            Request.startAnimating(view: self.view)

            let params:[String:Any] = ["product_id": ids! , "order_type": orderType , "item_type": itemType , "quantity": amountTxtField.text! , "size_id": sizeCurrntIndex! , "cut_id": slaughterCurrntIndex , "encapsulation_id": coveringCurrntIndex , "head_id": headCurrntIndex , "minced_quantity" :meetAmountCounter.text, "notes" : notesTxtField.text ?? "", "charity_id": charitiyCurrntIndex ?? "" ]
            let headers: HTTPHeaders = ["Lang": "ar" , "ApiToken": AppConstant.Token ?? ""]
            Request.req(url: URLs.addToCart , headers: headers, params: params, meth: .post) { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    
                    do {
                        let productDataDecoded = try decoder.decode(AddToCartModel.self, from: data)
                        switch productDataDecoded.key {
                        case "success":
                            Request.stopAnimating(view: self.view)
                            let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "TimeAndLocationViewController") as? TimeAndLocationViewController
                            self.navigationController?.pushViewController(vc!, animated: true)
                            
                            
                            
                        default:
                            print(error?.localizedDescription)
                            let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                            print(errorValue.msg as Any)
                            
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    func setReqData(){
        //
        if productArray?.isFav == true {
            favBtn.setImage(UIImage(named: "heart (5)"), for: .normal)
        } else {
            favBtn.setImage(UIImage(named: "favproduct"), for: .normal)
        }
        
        let imgUrl = self.productArray?.image
        self.imgView.kf.setImage(with: URL(string: imgUrl!))
        self.productName.text = self.productArray?.name
        self.descTxt.text = self.productArray?.desc
        self.txtRate.text = "(\(self.productArray?.countRate ?? 1))"
        self.starsRate.rating = Double(self.productArray?.avgRate ?? 1)
        if let array = self.productArray, let size = array.sizes, let cuts = array.cuts, let heads = array.heads, let encapsulations = array.encapsulations, let charities = array.charities{
            for Cuts  in size {
                self.productNameArray.append(Cuts.name!)
                self.productIdArray.append(Cuts.id!)
            }
            for cut in cuts{
                self.cutsNameArray.append(cut.name!)
                self.cutsIdArray.append(cut.id!)
            }
            for head in heads{
                self.headsNameArray.append(head.name!)
                self.headsIdArray.append(head.id!)
            }
            for encapsulate in encapsulations{
                self.encapsulationsNameArray.append(encapsulate.name!)
                self.encapsulationsIdArray.append(encapsulate.id!)
            }
            for charity in charities{
                self.charitiesNameArray.append(charity.name)
                self.charitiesIdArray.append(charity.id)
            }
        }
        self.sizeDropDown.optionArray = self.productNameArray
        self.sizeDropDown.optionIds = self.productIdArray
        self.dropDown(dropDown: self.sizeDropDown)
        self.selectdeSizeDropDown(dropDown: self.sizeDropDown)
        
        self.slaughteredDropDown.optionArray = self.cutsNameArray
        self.slaughteredDropDown.optionIds = self.cutsIdArray
        self.dropDown(dropDown: self.slaughteredDropDown)
        self.selectdeSlaughterDropDown(dropDown: self.slaughteredDropDown)
        self.headDropDown.optionArray = self.headsNameArray
        self.headDropDown.optionIds = self.headsIdArray
        self.dropDown(dropDown: self.headDropDown)
        self.selectdeHeadDropDown(dropDown: self.headDropDown)
        self.coveringDropDown.optionArray = self.encapsulationsNameArray
        self.coveringDropDown.optionIds = self.encapsulationsIdArray
        self.dropDown(dropDown: self.coveringDropDown)
        self.selectdeCoveringDropDown(dropDown: self.coveringDropDown)
        self.charitiesDropDown.optionArray = self.charitiesNameArray
        self.charitiesDropDown.optionIds = self.charitiesIdArray
        self.dropDown(dropDown: self.charitiesDropDown)
        self.selectdeCharityDropDown(dropDown: self.charitiesDropDown)
    }
    func normalReqBtnCall(){
        normalReqBtn.backgroundColor = .darkGray
        normalReqBtn.setTitleColor(UIColor(red: 255, green: 249, blue: 232, alpha: 1), for: .normal)
        charityReqBtn.backgroundColor = UIColor(red: 255, green: 249, blue: 232, alpha: 1)
        charityReqBtn.setTitleColor(.darkGray, for: .normal)
        charitiesTxt.isHidden = true
        charitiesDropDown.isHidden = true
    }
    func dropDown(dropDown :  DropDown){
        dropDown.checkMarkEnabled = false
        dropDown.arrowColor = .darkGray
        dropDown.selectedRowColor = .lightGray
    }
    func selectdeSizeDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.sizeCurrntIndex = index
            
        }
    }
    func selectdeSlaughterDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.slaughterCurrntIndex = index
            
        }
    }
    func selectdeCoveringDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.coveringCurrntIndex = index
            
        }
    }
    func selectdeHeadDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.headCurrntIndex = index
            
        }
    }
    func selectdeCharityDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.charitiyCurrntIndex = index
            
        }
    }
    
    func check() -> Bool{
        if amountTxtField.text == "0" {
            self.validation.showMessages(msg: NSLocalizedString("Set quantity number", comment: "").localized())
            return false
        }else{
            guard let _ = sizeDropDown.text, !(sizeDropDown.text?.isEmpty)! else {
                self.validation.showMessages(msg: NSLocalizedString("Choose Size", comment: "").localized())
                return false
            }
            if slaughteredSelected == true{
                guard let _ = slaughteredDropDown.text, !(slaughteredDropDown.text?.isEmpty)! else {
                    self.validation.showMessages(msg: NSLocalizedString("Choose slaughtered way", comment: "").localized())
                    return false
                }
                guard let _ = coveringDropDown.text, !(coveringDropDown.text?.isEmpty)! else {
                    self.validation.showMessages(msg: NSLocalizedString("Choose covering way", comment: "").localized())
                    return false
                }
                guard let _ = headDropDown.text, !(headDropDown.text?.isEmpty)! else {
                    self.validation.showMessages(msg: NSLocalizedString("Choose head type", comment: "").localized())
                    return false
                }
            }
            if charitySelected == true{
                guard let _ = charitiesDropDown.text, !(charitiesDropDown.text?.isEmpty)! else {
                    self.validation.showMessages(msg: NSLocalizedString("Choose charities", comment: "").localized())
                    return false
                }
            }
        }
        return true
    }
}
