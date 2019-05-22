//
//  Petrol.swift
//  My Auto
//
//  Created by Роберт Райсих on 17/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import Foundation
import RealmSwift

class Petrol: Object {
    @objc dynamic var pricePerLiter: String = ""
    @objc dynamic var mileage: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var date: String = ""
}
