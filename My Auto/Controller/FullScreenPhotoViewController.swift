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
    }
}
