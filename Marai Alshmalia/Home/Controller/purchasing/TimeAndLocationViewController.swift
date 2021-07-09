//
//  TimeAndLocationViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 04/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
class TimeAndLocationViewController: UIViewController {
    
    @IBOutlet var dateTxtField: UITextField!
    @IBOutlet var timeTxtField: UITextField!
    @IBOutlet var country: DropDown!
    @IBOutlet var neighborhood: DropDown!
    @IBOutlet var notesTxtField: UITextField!
    static var latitudeValue : Double?
    static var longitudeValue : Double?
    var dataArray : [CitiesDatum] = []
    var neighborhoodArray : [CitiesDatum] = []
    var citiesArray : [String] = []
    var citiesIdArray : [Int] = []
    var neighborhoodTitleArray : [String] = []
    var neighborhoodIdArray : [Int] = []
    var citiesCurrntIndex : Int?
    var neighborhoodCurrntIndex : Int?
    var validation = Validation()
    var map = MapViewController()
    private var datePickerView : UIDatePicker?
    private var timePickerView : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        createDataPicker()
        citesApi()
        neighborhoodApi()
        
        
    }
    
    @IBAction func mapBtnPressed(_ sender: Any) {
        //        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        //        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
                print("pressed")
                newOrderApi()
    }
    
//    @IBAction func continueBtnPressed(_ sender: Any) {
//        print("pressed")
//        newOrderApi()
//    }
    func createDataPicker() {
        datePickerView = UIDatePicker()
        timePickerView = UIDatePicker()
        datePickerView?.datePickerMode = .date
        timePickerView?.datePickerMode = .time
        dateTxtField.inputView = datePickerView
        timeTxtField.inputView = timePickerView
        datePickerView?.preferredDatePickerStyle = .compact
        datePickerView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        timePickerView?.preferredDatePickerStyle = .compact
        timePickerView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let datToolBar = UIToolbar()
        datToolBar.sizeToFit()
        let timeToolBar = UIToolbar()
        timeToolBar.sizeToFit()
        let dateDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        let timedDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed))
        dateTxtField.inputAccessoryView = datToolBar
        timeTxtField.inputAccessoryView = timeToolBar
        datToolBar.setItems([dateDoneBtn], animated: true)
        timeToolBar.setItems([timedDoneBtn], animated: true)
        
    }
    @objc func dateDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        dateTxtField.text = formatter.string(
            from: datePickerView!.date)
        self.view.endEditing(true)
        
    }
    @objc func timeDonePressed()  {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        timeTxtField.text = formatter.string(from: timePickerView!.date)
        self.view.endEditing(true)
        
    }
    func citesApi() {
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar"]
        
        Request.req(url: URLs.cities, headers: headers, params: params, meth: .get) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let decodedData = try decoder.decode(CitiesModel.self, from: data)
                    self.dataArray = decodedData.data!
                    switch decodedData.key {
                    case "success":
                        for citiesTitle in self.dataArray{
                            self.citiesArray.append(citiesTitle.title!)
                        }
                        for citiesId in self.dataArray{
                            self.citiesIdArray.append(citiesId.id!)
                        }
                        self.country.optionArray = self.citiesArray
                        self.country.optionIds = self.citiesIdArray
                        self.dropDown(dropDown: self.country)
                        self.selectdeCitiesDropDown(dropDown: self.country)
                        
                    //
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
    func neighborhoodApi() {
        let decoder = JSONDecoder()
        let params:[String:Any] = [: ]
        let headers: HTTPHeaders = ["Lang": "ar"]
        
        Request.req(url: URLs.neighborhood, headers: headers, params: params, meth: .get) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let decodedData = try decoder.decode(CitiesModel.self, from: data)
                    self.neighborhoodArray = decodedData.data!
                    switch decodedData.key {
                    case "success":
                        for neighborhoodTitle in self.neighborhoodArray{
                            self.neighborhoodTitleArray.append(neighborhoodTitle.title!)
                        }
                        for neighborhoodId in self.neighborhoodArray{
                            self.neighborhoodIdArray.append(neighborhoodId.id!)
                        }
                        self.neighborhood.optionArray = self.neighborhoodTitleArray
                        self.neighborhood.optionIds = self.neighborhoodIdArray
                        
                        self.dropDown(dropDown: self.neighborhood)
                        self.selectdNeighbourhoodDropDown(dropDown: self.neighborhood)
                    //
                    default:
                        print(error!)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        print(errorValue.msg as Any)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        
    }
    func dropDown(dropDown :  DropDown){
        dropDown.checkMarkEnabled = false
        dropDown.arrowColor = .darkGray
        dropDown.selectedRowColor = .lightGray
    }
    func selectdeCitiesDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.citiesCurrntIndex = index
            //    self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }
    
    func selectdNeighbourhoodDropDown(dropDown :  DropDown){
        dropDown.didSelect{(selectedText , index ,id) in
            self.neighborhoodCurrntIndex = index
            //    self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
        }
    }
    
    static func setCoordinate(longitud: Double, latitude: Double) {
        longitudeValue = longitud
        latitudeValue = latitude
    }
    func newOrderApi() {
        let decoder = JSONDecoder()
        if check() == true {
//            Request.startAnimating(view: self.view)
            let params:[String:Any] = ["delivery_date" : dateTxtField.text!  , "delivery_time" : timeTxtField.text! , "city_id": citiesCurrntIndex! , "neighbourhood_id": neighborhoodCurrntIndex!, "notes": notesTxtField.text ?? "" , "lat" : TimeAndLocationViewController.latitudeValue ?? 0.0 , "lng": TimeAndLocationViewController.longitudeValue ?? 0.0,"coupon_num": "" ]
            let headers: HTTPHeaders = ["Lang": "ar" , "ApiToken": AppConstant.Token ?? ""]
            Request.req(url: URLs.newOrder, headers: headers, params: params, meth: .post) { (data, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    do {
//                        Request.stopAnimating(view: self.view)
                        let decodedData = try decoder.decode(NewOrderModel.self, from: data)
                        switch decodedData.key {
                        case "success":
                            print("success")
                            let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "ConfirmPurchaseViewController") as? ConfirmPurchaseViewController
                            self.navigationController?.pushViewController(vc!, animated: true)
                        default:
                            let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                            print(errorValue.msg as Any)
                            print("errorr")
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        }
        
    }
    func check() -> Bool{
        
        guard let _ = dateTxtField.text, !(dateTxtField.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("Set received date", comment: "").localized())
            return false
        }
        guard let _ = timeTxtField.text, !(timeTxtField.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("Set received time", comment: "").localized())
            return false
        }
        guard let _ = country.text, !(country.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("Choose country", comment: "").localized())
            return false
        }
        guard let _ = neighborhood.text, !(neighborhood.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("Choose neighborhood", comment: "").localized())
            return false
        }
        if TimeAndLocationViewController.latitudeValue == nil || TimeAndLocationViewController.longitudeValue == nil{
            self.validation.showMessages(msg: NSLocalizedString("Click on map to set location", comment: "").localized())
            return false
            
        }
        return true
    }
}
