//
//  MyAutosViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 12/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift

class MyAutosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myCarsTableView: UITableView!
    
    var numberOfCells: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCarsTableView.delegate = self
        myCarsTableView.dataSource = self
        myCarsTableView.register(UINib(nibName: "MyCarTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCarCell")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func AddButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToAddCar", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let Array = realm.objects(Car.self)
        numberOfCells = Array.count
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCarCell") as! MyCarTableViewCell
        let realm = try! Realm()
        let Array = realm.objects(Car.self)
        numberOfCells = Array.count
        
        cell.markLabel.text = Array[indexPath.row].mark
        cell.modelLabel.text = Array[indexPath.row].model
        cell.yearLabel.text = Array[indexPath.row].year
        cell.numberLabel.text = Array[indexPath.row].number 
        
        return cell
    }
    
    
    
}
