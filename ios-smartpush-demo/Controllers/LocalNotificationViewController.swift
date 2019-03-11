//
//  LocalNotificationViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 18/02/19.
//  Copyright © 2019 Carlos Correa. All rights reserved.
//

import UIKit

enum Categorys:NSInteger{
    case PushNormal = 0,
    PushEmoji,
    PushImage,
    PushGif,
    PushAudio,
    PushVideo,
    PushCarouselCoverflow,
    PushCarouselRotary,
    PushCarouselCylinder,
    PushCarouselCylinderInverted,
    PushCarouselLinear,
    PushCarouselStack,
    PushCarouselStackInverted
}

let banner1 = "http://image.buscape.com//mobile//notifications//android//0110galax.png"
let banner2 = "http://image.buscape.com/mobile/notifications/android/1512note.png"
let banner3 = "http://image.buscape.com/mobile/notifications/android/1312phone.png"
let banner4 = "http://image.buscape.com/mobile/notifications/android/1001cafeteira.png"
let banner5 = "http://image.buscape.com/mobile/notifications/android/1304gela.png"
let banner6 = "http://image.buscape.com//mobile//notifications//android//2507Tablet.png"
let banners = [banner1, banner2, banner3, banner4, banner5, banner6];

class LocalNotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionPushNormal(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.category = "PUSH"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushEmoji(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você 😃"
        notification.category = "PUSH"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushImage(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "https://s.aolcdn.com/hss/storage/midas/b386937631a1f03665c1d57289070898/203417456/simpsons.jpg"
        notification.category = "BANNER"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushGif(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "https://media.giphy.com/media/qi29MoLjWNPUI/giphy.gif"
        notification.category = "GIF"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushAudio(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "http://www.audiocheck.net/Audio/audiocheck.net_welcome.mp3"
        notification.category = "AUDIO"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushVideo(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "0S6pHex-KCo"
        notification.category = "VIDEO"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushCoverflow(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "COVERFLOW"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushRotary(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "ROTARY"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushCylinder(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "CYLINDER"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushCylinderInverted(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "INVERTED"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushLinear(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "LINEAR"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushStack(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "TIME_MACHINE"
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushStackInverted(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = "TIME_MACHINE_INVERTED"
        requestPushNotification(notification)
    }
    
    private func showError(){
        UIAlertView(title: "Erro", message: "Ocorreu um erro", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func showSuccess(){
        UIAlertView(title: "Success", message: "Solicitação enviada", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func requestPushNotification(_ notification: SmartpushNotification) {
        let builder  = SmartpushNotificationBuilder()
        builder.title = notification.title
        builder.body = notification.body
        builder.category = notification.category
        builder.carouselType = notification.carouselType
        builder.mediaUrl = notification.mediaUrl
        builder.banners = notification.banners
        builder.build()
    }
    
}
