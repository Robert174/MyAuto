//
//  RepairsViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 16/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift

class RepairsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var addRepairView: UIView! {
        didSet{
            self.addRepairView.layer.cornerRadius = 10
            self.addRepairView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.addRepairView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var opacityView: UIView!{
        didSet{
            self.opacityView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        }
    }
    
    @IBOutlet weak var totalLabelView: UIView! {
        didSet{
            self.totalLabelView.backgroundColor = #colorLiteral(red: 0.262098521, green: 0.539827168, blue: 0.6507278681, alpha: 1)
        }
        
    }
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var repairTableView: UITableView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var dateTextInput: UITextField!
    @IBOutlet weak var serviseNameTextField: UITextField!
    @IBOutlet weak var repairerNameTextField: UITextField!
    @IBOutlet weak var repairerNumberTextField: UITextField!
    
    var numberOfCells: Int = 0
    let realm = try! Realm()
    var indexOfChosenCell: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.opacityView.isHidden = true
        
        repairTableView.delegate = self
        repairTableView.dataSource = self
        
        showTotalExpenses()
        
        repairTableView.register(UINib(nibName: "RepairTableViewCell", bundle: nil), forCellReuseIdentifier: "repairCell")
    }
    
    @IBAction func openModalButtonPressed(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        self.dateTextInput.text = formatter.string(from: Date())
        self.opacityView.isHidden = false
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        checkTextFields()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        opacityView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let Array = realm.objects(Repair.self)
        numberOfCells = Array.count
        
        return numberOfCells
    }
    
    func checkTextFields() {
        if (typeTextField.text != "" && serviseNameTextField.text != "" && priceTextField.text != "") {
            writeRepairInRealm()
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
    
    func writeRepairInRealm() {
        let repair = Repair()
        do {
            try realm.write {
                repair.paid = priceTextField.text!
                repair.service = serviseNameTextField.text!
                repair.type = typeTextField.text!
                repair.date = dateTextInput.text!
                repair.repairerName = repairerNameTextField.text ?? "Не указали"
                repair.repairerNumber = repairerNumberTextField.text ?? "Не указали"
                realm.add(repair)
            }
        } catch {
            print(error)
        }
        repairTableView.reloadData()
        self.opacityView.isHidden = true
        showTotalExpenses()
        clearTextFields()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repairCell") as! RepairTableViewCell
        
        let Array = realm.objects(Repair.self)
        numberOfCells = Array.count
        cell.paidLabel.text = Array.reversed()[indexPath.row].paid
        cell.typeLabel.text = Array.reversed()[indexPath.row].type
        cell.dateLabel.text = Array.reversed()[indexPath.row].date
        cell.serviceLabel.text = Array.reversed()[indexPath.row].service
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexOfChosenCell = indexPath[1]
        performSegue(withIdentifier: "goToRepairFullInfo", sender: self)
    }
    
    func showTotalExpenses() {
        let Array = realm.objects(Repair.self)
        var totalExpenses: Double = 0
        if (Array.count > 0) {
            for e in 0 ... Array.count - 1 {
                totalExpenses += Double(Array[e].paid) ?? 0
            }
        }
        else{
            totalExpenses = 0
        }
        totalExpenses = Double(round(100*totalExpenses)/100)
        totalExpensesLabel.text = "\(String(totalExpenses))₽"
    }
    
    func clearTextFields() {
        priceTextField.text = ""
        serviseNameTextField.text = ""
        typeTextField.text = ""
        dateTextInput.text = ""
        repairerNameTextField.text = ""
        repairerNumberTextField.text = ""
    }
    
    @IBAction func dp(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateTextInput.text = dateFormatter.string(from: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRepairFullInfo"{
            
            let repairFullInfo = segue.destination as! RepairFullInfoViewController
            repairFullInfo.chosenCellIndex = indexOfChosenCell
        }
    }
}
