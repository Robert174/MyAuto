//
//  ChangeCarDataViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 22/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift

class ChangeCarDataViewController: UIViewController {
    
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    var brand = ""
    var model = ""
    var year = ""
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPlaceholders()
    }
    
    var newCar = Car()
    let realm = try! Realm()
    
    @IBAction func changeButtonPressed(_ sender: Any) {
        if ((brandTextField.text != "") && (modelTextField.text != "") && (yearTextField.text != "") && (numberTextField.text != "")){
            newCar.mark = brandTextField.text!
            newCar.model = modelTextField.text!
            newCar.year = yearTextField.text!
            newCar.number = numberTextField.text!
            
            checkCarExistence()
        }
        else{
            showAlert()
        }
    }
    
    func setPlaceholders() {
        brandTextField.placeholder = brand
        modelTextField.placeholder = model
        yearTextField.placeholder = year
        numberTextField.placeholder = number
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

}
