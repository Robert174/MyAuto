//
//  Car.swift
//  My Auto
//
//  Created by Роберт Райсих on 14/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//
import Foundation
import RealmSwift

class Car: Object {
    @objc dynamic var mark: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var number: String = ""
    @objc dynamic var mileage: String = ""
}




