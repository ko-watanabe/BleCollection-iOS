//
//  DateExtension.swift
//  CampusLifeLogBeaconScanner
//
//  Created by Ko Watanabe on 2017/12/15.
//  Copyright © 2017年 Ko Watanabe. All rights reserved.
//

import Foundation

extension Date{
    func toString() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        let format = "yyyy/MM/dd HH:mm:ss"
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
