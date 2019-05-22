//
//  MyCarViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 18/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift
import Charts
import Alamofire
import SwiftyJSON


class MyCarViewController: UIViewController {

    
    @IBOutlet weak var noCarView: UIView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var mileageLabel: UILabel!
    
    
    let realm = try! Realm()
    
    var repairChartDataEntry = PieChartDataEntry(value: 0)
    var petrolChartDataEntry = PieChartDataEntry(value: 0)
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    var arrayOfCars : [String] = []
   
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let myCar = realm.objects(Car.self)
        checkCar(myCar: myCar)
        showTotalExpenses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pieChart.chartDescription?.text = ""
        repairChartDataEntry.label = "Rep"
        petrolChartDataEntry.label = "Oil"
        numberOfDownloadsDataEntries = [repairChartDataEntry, petrolChartDataEntry]
        
        showTotalExpenses()
        updateChartData()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if addButton.title == "Изменить"{
            performSegue(withIdentifier: "goToChangeCarData", sender: self)
        }
        else{
            performSegue(withIdentifier: "goToAddCarScreen", sender: self)
        }
    }
    
    func checkCar(myCar: Results<Car>) {
        let myCar = realm.objects(Car.self)
        if (myCar.count == 1) {
            noCarView.isHidden = true
            addButton.title = "Изменить"
            markLabel.text = myCar[0].mark
            modelLabel.text = myCar[0].model
            yearLabel.text = myCar[0].year
            numberLabel.text = myCar[0].number
        }
        else {
            getCarMakes()
            print(Realm.Configuration.defaultConfiguration.fileURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddCarScreen" {
            let secondVC = segue.destination as! AddCarViewController
            secondVC.arrayOfCars = self.arrayOfCars
        }
        if segue.identifier == "goToChangeCarData"{
            let changeCarVC = segue.destination as! ChangeCarDataViewController
            changeCarVC.brand = markLabel.text!
            changeCarVC.model = modelLabel.text!
            changeCarVC.year = yearLabel.text!
            changeCarVC.number = numberLabel.text!
        }
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    func getCarMakes() {
        let url = "https://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json"
        Alamofire.request(url,method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                let carsJSON : JSON = JSON(response.result.value!)
                for i in 0...75{
                    self.arrayOfCars.append(carsJSON["Results"][i]["Make_Name"].string ?? "")
                }
                print("end")
            }
            else{
                print("Ошибка запроса")
            }
        }
    }
    
    
    func showTotalExpenses() {
        petrolChartDataEntry.value = 0
        repairChartDataEntry.value = 0
        let ArrayRep = realm.objects(Repair.self)
        let ArrayPetr = realm.objects(Petrol.self)
        if (ArrayRep.count > 0) {
            for e in 0 ... ArrayRep.count - 1 {
                repairChartDataEntry.value += Double(ArrayRep[e].paid) ?? 0
            }
        }
        else{
            repairChartDataEntry.value = 0
        }
        
        if (ArrayPetr.count > 0) {
            mileageLabel.text = "\(ArrayPetr[ArrayPetr.count - 1].mileage) км"
            
            for e in 0 ... ArrayPetr.count - 1 {
                petrolChartDataEntry.value += Double(ArrayPetr[e].price) ?? 0
            }
        }
        else{
            petrolChartDataEntry.value = 0
        }
        repairChartDataEntry.value = Double(round(100*repairChartDataEntry.value)/100)
        petrolChartDataEntry.value = Double(round(100*petrolChartDataEntry.value)/100)
    }
    
}
