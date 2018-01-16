//
//  ViewController.swift
//  iPhonアプリの画面をコントロールするためのファイル。このファイルに書くことでアプリを作り込んでいく。アプリ開発で最も使用するファイル。
//  CampusLifeLogBeaconScanner
//
//  Created by Ko Watanabe on 2017/12/15.
//  Copyright © 2017年 Ko Watanabe. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class ViewController: UIViewController {

    let beaconManager = BeaconManager.shared
    let center = NotificationCenter.default
    
    @IBOutlet weak var beaconLogTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    override func viewDidDisappear(_ animated: Bool) {
        removeObserver()
    }
}

extension ViewController{
    func addObserver() {
        center.addObserver(self,
                           selector: #selector(type(of: self).notified(notification:)),
                           name: .didRangeBeacons,
                           object: nil)
    }
    func removeObserver() {
        center.removeObserver(self)
    }
    
    /** C: 今回、通知された時に呼ばれる用のメソッド */
    @objc private func notified(notification: Notification) {
        print("呼ばれた(　´･‿･｀): \(notification)")
    
        if let beacons = notification.object as? [CLBeacon]{
            for beacon in beacons {
                let minor = beacon.minor
                let major = beacon.major
                let rssi = beacon.rssi
                var beaconDetails = "Major: \(major) "
                beaconDetails += "Minor: \(minor) "
                beaconDetails += "RSSI:\(rssi)"
                print(beaconDetails)
                beaconLogTextView.text = beaconDetails
                
                //Realmにデータを保存
                let beaconData = Beacon()
                beaconData.major = Int(truncating: major)
                beaconData.minor = Int(truncating: minor)
                beaconData.rssi = rssi
                
                let realm = try! Realm()
                
                try! realm.write{
                    realm.add(beaconData)
                }
            }
        }
    
    }

}


