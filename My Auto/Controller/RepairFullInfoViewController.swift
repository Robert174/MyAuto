//
//  RepairFullInfoViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 21/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit
import RealmSwift

class RepairFullInfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var chosenCellIndex = 0
    let realm = try! Realm()
    
    @IBOutlet weak var repairLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var repairerNameLabel: UILabel!
    @IBOutlet weak var repairerNumberLabel: UILabel!
    
    @IBOutlet weak var imageTake: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        fillLabels()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageTake.isUserInteractionEnabled = true
        imageTake.addGestureRecognizer(tapGestureRecognizer)
       
    }
    

    
    func fillLabels() {
        let Array = realm.objects(Repair.self)
        dateLabel.text = Array.reversed()[chosenCellIndex].date
        priceLabel.text = Array.reversed()[chosenCellIndex].paid
        repairLabel.text = Array.reversed()[chosenCellIndex].type
        serviceLabel.text = Array.reversed()[chosenCellIndex].service
        repairerNameLabel.text = Array.reversed()[chosenCellIndex].repairerName
        repairerNumberLabel.text = Array.reversed()[chosenCellIndex].repairerNumber
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageTake.image = image
            print(image)
            imagePicker.dismiss(animated: true, completion: nil)
        }
        else{
            print("There was an error with picking image")
        }
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "goToFullScreenPhoto", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFullScreenPhoto"{
            let fullScreenPhoto = segue.destination as! FullScreenPhotoViewController
            fullScreenPhoto.newImage = imageTake.image
            
        }
    }
    
}

