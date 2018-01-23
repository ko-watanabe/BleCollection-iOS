//
//  BeaconManager.swift
//  CampusLifeLogBeaconScanner
//
//  Created by Ko Watanabe on 2017/12/15.
//  Copyright © 2017年 Ko Watanabe. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = BeaconManager()
    let center = NotificationCenter.default     //通知を管理する場所
    
    var locationManager:CLLocationManager!
    var beaconRegion:CLBeaconRegion!
    
    let UUIDList = [
        "00000000-1234-1234-ABCD-123456789ABC",
        ]
    
    func setup() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1
        let status = CLLocationManager.authorizationStatus()
        print("CLAuthorizedStatus: \(status.rawValue)");
        if(status == .notDetermined) {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    private func startMonitoring() {
        for uuid in UUIDList {
            beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: uuid)!, identifier: uuid)
            beaconRegion.notifyEntryStateOnDisplay = false
            beaconRegion.notifyOnEntry = true
            beaconRegion.notifyOnExit = true
            locationManager.startMonitoring(for: beaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus");
        switch (status) {
        case .notDetermined:
            print("not determined")
            break
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("denied")
            break
        case .authorizedAlways:
            print("authorizedAlways")
            startMonitoring()
            break
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            startMonitoring()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        manager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch (state) {
        case .inside:
            print("iBeacon inside")
            manager.startRangingBeacons(in: region as! CLBeaconRegion)
            break;
        case .outside:
            print("iBeacon outside")
            break;
        case .unknown:
            print("iBeacon unknown")
            break;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if(beacons.count > 0){
            center.post(name: .didRangeBeacons, object: beacons)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion: iBeacon found");
        manager.startRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion: iBeacon lost");
        manager.stopRangingBeacons(in: region as! CLBeaconRegion)
    }
}
