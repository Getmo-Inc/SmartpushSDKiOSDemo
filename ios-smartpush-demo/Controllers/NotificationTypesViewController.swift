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
        requestPushNotification(.PushNormalTest)
    }
    
    @IBAction func actionPushEmoji(_ sender: UIButton) {
        requestPushNotification(.PushEmojiTest)
    }
    
    @IBAction func actionPushImage(_ sender: UIButton) {
        requestPushNotification(.PushImageTest)
    }
    
    @IBAction func actionPushGif(_ sender: UIButton) {
        requestPushNotification(.PushGifTest)
    }
    
    @IBAction func actionPushAudio(_ sender: UIButton) {
        requestPushNotification(.PushAudioTest)
    }
    
    @IBAction func actionPushVideo(_ sender: UIButton) {
        requestPushNotification(.PushVideoTest)
    }
    
    @IBAction func actionPushCoverflow(_ sender: UIButton) {
        requestPushNotification(.PushCarouselCoverflowTest)
    }
    
    @IBAction func actionPushRotary(_ sender: UIButton) {
        requestPushNotification(.PushCarouselRotaryTest)
    }
    
    @IBAction func actionPushCylinder(_ sender: UIButton) {
        requestPushNotification(.PushCarouselCylinderTest)
    }
    
    @IBAction func actionPushCylinderInverted(_ sender: UIButton) {
        requestPushNotification(.PushCarouselCylinderInvertedTest)
    }
    
    @IBAction func actionPushLinear(_ sender: UIButton) {
        requestPushNotification(.PushCarouselLinearTest)
    }
    
    @IBAction func actionPushStack(_ sender: UIButton) {
        requestPushNotification(.PushCarouselStackTest)
    }
    
    @IBAction func actionPushStackInverted(_ sender: UIButton) {
        requestPushNotification(.PushCarouselStackInvertedTest)
    }
    
    private func showError(){
        UIAlertView(title: "Erro", message: "Ocorreu um erro", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func showSuccess(){
        UIAlertView(title: "Success", message: "Solicitação enviada", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func requestPushNotification(_ type: NotificationTypeTest) {
        
        SmartpushNotificationTest.requestNotification(by: type, isProd: false) { (success) in
            if success {
                self.showSuccess()
            } else {
                self.showError()
            }
        }
    }
    
}
