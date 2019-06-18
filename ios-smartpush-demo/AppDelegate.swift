//
//  AppDelegate.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 11/12/18.
//  Copyright © 2018 Getmo. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMaps
import SideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SmartpushSDKDelegate, UNUserNotificationCenterDelegate  {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NSSetUncaughtExceptionHandler { (exception) in
            print("******************************************************")
            print("FatalError: \(exception)")
            for i in exception.callStackSymbols {
                print("\n\(i)")
            }
            print("******************************************************")
        }
        
        let shared = SmartpushSDK.sharedInstance()
        shared?.delegate = self
        shared?.didFinishLaunching(options: launchOptions)
        shared?.registerForPushNotifications()
        
        GMSServices.provideAPIKey("AIzaSyA8MhV4bR87HRxEUULksAev2JswkeMYktY")
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 10.0/255.0, green: 168.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let application = UIApplication.shared
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]){
        SmartpushSDK.sharedInstance().didReceiveRemoteNotification(userInfo)
        print(userInfo)
    }
    
    func onPushAccepted(_ push: [AnyHashable: Any]!, andOpenFromPush openFromPush: Bool) {
        print("CARLOS: onPushAccepted. OpenFromPush: \(openFromPush)")
    }
    
    func onPushAccepted(_ push: [AnyHashable : Any]!, andOpenFromPush openFromPush: Bool, withUri uri: String!) {
        print("CARLOS: onPushAccepted. OpenFromPush: \(openFromPush). WithUri: \(uri)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error:Error){
        SmartpushSDK.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        SmartpushSDK.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
        
        let token = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        print("Token: \(token)")
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings){
        SmartpushSDK.sharedInstance().didRegister(notificationSettings)
    }
    
    func application(_ application: UIApplication, continue userActivity:NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard let url = userActivity.webpageURL else {return false}
        
//        print(url.absoluteString)
//
//        if let fingerprint = SmartpushSDK.sharedInstance()?.deviceFingerPrint {
//            print(fingerprint)
//        }
    
        return false
    }
}
