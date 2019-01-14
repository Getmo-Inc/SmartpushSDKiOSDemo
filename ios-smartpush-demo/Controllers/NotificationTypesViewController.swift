//
//  NotificationTypesViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 08/01/19.
//  Copyright © 2019 Carlos Correa. All rights reserved.
//

import UIKit

class NotificationTypesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionPushNormal(_ sender: UIButton) {
        requestPushNotification(.PushNormal)
    }
    
    @IBAction func actionPushEmoji(_ sender: UIButton) {
        requestPushNotification(.PushEmoji)
    }
    
    @IBAction func actionPushImage(_ sender: UIButton) {
        requestPushNotification(.PushImage)
    }
    
    @IBAction func actionPushGif(_ sender: UIButton) {
        requestPushNotification(.PushGif)
    }
    
    @IBAction func actionPushAudio(_ sender: UIButton) {
        requestPushNotification(.PushAudio)
    }
    
    @IBAction func actionPushVideo(_ sender: UIButton) {
        requestPushNotification(.PushVideo)
    }
    
    @IBAction func actionPushCoverflow(_ sender: UIButton) {
        requestPushNotification(.PushCarouselCoverflow)
    }
    
    @IBAction func actionPushRotary(_ sender: UIButton) {
        requestPushNotification(.PushCarouselRotary)
    }
    
    @IBAction func actionPushCylinder(_ sender: UIButton) {
        requestPushNotification(.PushCarouselCylinder)
    }
    
    @IBAction func actionPushCylinderInverted(_ sender: UIButton) {
        requestPushNotification(.PushCarouselCylinderInverted)
    }
    
    @IBAction func actionPushLinear(_ sender: UIButton) {
        requestPushNotification(.PushCarouselLinear)
    }
    
    @IBAction func actionPushStack(_ sender: UIButton) {
        requestPushNotification(.PushCarouselStack)
    }
    
    @IBAction func actionPushStackInverted(_ sender: UIButton) {
        requestPushNotification(.PushCarouselStackInverted)
    }
    
    private func showError(){
        UIAlertView(title: "Erro", message: "Ocorreu um erro", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func showSuccess(){
        UIAlertView(title: "Success", message: "Solicitação enviada", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func requestPushNotification(_ type: NotificationType) {
        
        SmartpushNotificationTest.requestNotification(by: type, isProd: false) { (success) in
            if success {
                self.showSuccess()
                
            } else {
                self.showError()
            }
        }
    }
    
}
