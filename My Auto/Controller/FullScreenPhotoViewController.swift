//
//  FullScreenPhotoViewController.swift
//  My Auto
//
//  Created by Роберт Райсих on 22/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {

    var newImage: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = newImage
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

}
