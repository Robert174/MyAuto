//
//  AddPetrolViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 16/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift

class AddPetrolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var totalLabelView: UIView!{
        didSet{
            self.totalLabelView.backgroundColor = #colorLiteral(red: 0.262098521, green: 0.539827168, blue: 0.6507278681, alpha: 1)
        }
    }
    @IBOutlet weak var petrolTableView: UITableView!
    @IBOutlet weak var opacityView: UIView!{
        didSet
            {
                self.opacityView.backgroundColor = UIColor(white: 1, alpha: 0.5)
            }
    }
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var infoView: UIView! {
        didSet{
            self.infoView.layer.cornerRadius = 10
            self.infoView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.infoView.layer.borderWidth = 1
        }
        
    }
    @IBOutlet weak var mileageTextField: UITextField!
    @IBOutlet weak var litersTextField: UITextField!
    @IBOutlet weak var pricePerLiterTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    let realm = try! Realm()
    var numberOfCells: Int = 0
    var lastMileage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.opacityView.isHidden = true
        // Do any additional setup after loading the view.
        litersTextField.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControl.Event.editingChanged)
        pricePerLiterTextField.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControl.Event.editingChanged)
        showTotalExpensesAndMileAge()
        petrolTableView.delegate = self
        petrolTableView.dataSource = self
        petrolTableView.register(UINib(nibName: "PetrolTableViewCell", bundle: nil), forCellReuseIdentifier: "petrolCell")
    }
    
    
    @IBAction func openModalButtonPressed(_ sender: Any) {
        self.opacityView.isHidden = false
        self.mileageTextField.placeholder = String(lastMileage)
    }
    
    @IBAction func addInfoButtonPressed(_ sender: Any) {
        checkValues()
    }
    
    func checkValues() {
        if (litersTextField.text != "" && pricePerLiterTextField.text != "" && mileageTextField.text != "")
        {
            let lastMileage = Int(mileageTextField.placeholder!)
            let mileage = Int(mileageTextField.text!)
            if (lastMileage! >= mileage!){
                showAlert(title: "Ошибка ввода пробега", message: "Текущий пробег должен быть больше прошлого")
                return
            }
            writePetrolInRealm()
        }
        else{
            showAlert(title: "Заполните все поля", message: "Это сделано для вашего удобства, эти данные хранятся только у вас на телефоне, мы не можем их просматривать.")
        }
    }
    
    func showAlert(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            let Array = realm.objects(Petrol.self)
            let itemsToDelete = realm.objects(Petrol.self).filter("mileage = %@", Array.reversed()[indexPath.row].mileage )
            try! realm.write {
                realm.delete(itemsToDelete)
            }
            showTotalExpensesAndMileAge()
            tableView.reloadData()
        }
    }
    
    func writePetrolInRealm() {
        let petrol = Petrol()
        do {
            try realm.write {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                petrol.mileage = mileageTextField.text!
                petrol.price = totalLabel.text!
                petrol.pricePerLiter = pricePerLiterTextField.text!
                petrol.date = formatter.string(from: Date())
                realm.add(petrol)
            }
        } catch {
            print(error)
        }
        
        self.opacityView.isHidden = true
        petrolTableView.reloadData()
        cleanTextFields()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        opacityView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let Array = realm.objects(Petrol.self)
        numberOfCells = Array.count
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petrolCell") as! PetrolTableViewCell
        let Array = realm.objects(Petrol.self)
        
        numberOfCells = Array.count
        showTotalExpensesAndMileAge()
        
        cell.costLabel.text = "Итого: \(Array.reversed()[indexPath.row].price)₽"
        cell.dateLabel.text = Array.reversed()[indexPath.row].date
        cell.pricePerLiterLabel.text = "\(Array.reversed()[indexPath.row].pricePerLiter)₽/л"
        
        return cell
    }
    
    func checkValue(someOptional: String?) -> Double {
        if let value = someOptional {
            return Double(value) ?? 0
        }
        else {
            return 0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        totalLabel.text = String(checkValue(someOptional: litersTextField.text) * checkValue(someOptional: pricePerLiterTextField.text))
    }
    
    func showTotalExpensesAndMileAge() {
        let Array = realm.objects(Petrol.self)
        
        var totalExpenses: Double = 0
        if (Array.count > 0) {
            lastMileage = Int(Array[Array.count - 1].mileage) ?? 0
            for e in 0 ... Array.count - 1 {
                totalExpenses += Double(Array[e].price) ?? 0
            }
        }
        else{
            totalExpenses = 0
            lastMileage = 0
        }
        totalExpenses = Double(round(100*totalExpenses)/100)
        total.text = "\(String(totalExpenses))₽"
    }
    
    func cleanTextFields() {
        mileageTextField.text = ""
        litersTextField.text = ""
        pricePerLiterTextField.text = ""
    }
}
