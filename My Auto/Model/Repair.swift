//
//  File.swift
//  My Auto
//
//  Created by Роберт Райсих on 17/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import Foundation
import RealmSwift

class Repair: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var paid: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var service: String = ""
    @objc dynamic var repairerName: String = ""
    @objc dynamic var repairerNumber: String = ""
}
