//
//  AppDelegate.swift
//  ユーザがアプリを起動した時に最初に呼ばれるファイル。アプリの起動時や、バックグラウンドの状態に移行するタイミングでアプリの動作を変更したい場合はこのファイルにコードを書く。
//  CampusLifeLogBeaconScanner
//
//  Created by Ko Watanabe on 2017/12/15.
//  Copyright © 2017年 Ko Watanabe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("アプリ閉じそうな時に呼ばれる")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("アプリを閉じた時に呼ばれる")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("アプリを開きそうな時に呼ばれる")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("アプリを開いた時に呼ばれる")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("フリックしてアプリを終了させた時に呼ばれる")
    }
    
    
}

