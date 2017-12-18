//
//  Beacon.swift
//  CampusLifeLogBeaconScanner
//
//  Created by Ko Watanabe on 2017/12/15.
//  Copyright © 2017年 Ko Watanabe. All rights reserved.
//

import UIKit
import RealmSwift

class Beacon: Object {
    @objc dynamic var date:String = Date().toString()
    @objc dynamic var major:Int = 0
    @objc dynamic var minor:Int = 0
    @objc dynamic var rssi:Int = 0
}

