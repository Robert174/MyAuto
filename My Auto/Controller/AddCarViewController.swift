//
//  AddCarViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 13/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class AddCarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var markTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    var newCar = Car()
    let realm = try! Realm()
    let thePicker = UIPickerView()
    var arrayOfCars : [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markTextField.inputView = thePicker
        thePicker.delegate = self
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if ((markTextField.text != "") && (modelTextField.text != "") && (yearTextField.text != "") && (numberTextField.text != "")){
            newCar.mark = markTextField.text!
            newCar.model = modelTextField.text!
            newCar.year = yearTextField.text!
            newCar.number = numberTextField.text!
            
            checkCarExistence()
        }
        else{
            showAlert()
        }
    }
    
    func showAlert() {
        // create the alert
        let alert = UIAlertController(title: "Заполните все поля.", message: "Это сделано для вашего удобства, эти данные хранятся только у вас на телефоне, мы не можем их просматривать.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkCarExistence(){
        let car = realm.objects(Car.self)
        if (car.count == 0) {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(newCar)
                }
            } catch {
                print(error)
            }
            print(Realm.Configuration.defaultConfiguration.fileURL)
            
            self.navigationController?.popViewController(animated: true)
        }
        else {
            try! realm.write {
                car[0].mark = newCar.mark
                car[0].model = newCar.model
                car[0].year = newCar.year
                car[0].number = newCar.number
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfCars.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfCars[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        markTextField.text = arrayOfCars[row]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
