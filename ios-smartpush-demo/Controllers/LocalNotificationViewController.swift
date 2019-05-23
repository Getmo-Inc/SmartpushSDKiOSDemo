//
//  LocalNotificationViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 18/02/19.
//  Copyright © 2019 Carlos Correa. All rights reserved.
//

import UIKit

enum Categorys:String{
    case PushNormal = "PUSH",
    PushEmoji = "EMOJI",
    PushImage = "BANNER",
    PushGif = "GIF",
    PushAudio = "AUDIO",
    PushVideo = "VIDEO",
    PushCarouselCoverflow = "COVERFLOW",
    PushCarouselRotary = "ROTARY",
    PushCarouselCylinder = "CYLINDER",
    PushCarouselCylinderInverted = "INVERTED" ,
    PushCarouselLinear = "LINEAR",
    PushCarouselStack = "TIME_MACHINE",
    PushCarouselStackInverted = "TIME_MACHINE_INVERTED"
}

let banner1 = "http://cdn.getmo.com.br/images/1512note.png"
let banner2 = "http://cdn.getmo.com.br/images/1312phone.png"
let banner3 = "http://cdn.getmo.com.br/images/2607fog.png"
let banner4 = "http://cdn.getmo.com.br/images/1001cafeteira.png"
let banner5 = "http://cdn.getmo.com.br/images/0110galax.png"
let banner6 = "http://cdn.getmo.com.br/images/2507Tablet.png"
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
        notification.category = Categorys.PushEmoji.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushImage(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "http://cdn.getmo.com.br/images/1512note.png"
        notification.category = Categorys.PushImage.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushGif(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "https://media.giphy.com/media/qi29MoLjWNPUI/giphy.gif"
        notification.category = Categorys.PushGif.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushAudio(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "http://www.audiocheck.net/Audio/audiocheck.net_welcome.mp3"
        notification.category = Categorys.PushAudio.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushVideo(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.mediaUrl = "i4YRWxaFjZo"
        notification.category = Categorys.PushVideo.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushCoverflow(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselCoverflow.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushRotary(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselRotary.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushCylinder(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselCylinder.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushCylinderInverted(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselCylinderInverted.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushLinear(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselLinear.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushStack(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselStack.rawValue
        requestPushNotification(notification)
    }
    
    @IBAction func actionPushStackInverted(_ sender: UIButton) {
        let notification  = SmartpushNotification()
        notification.title = "Oferta"
        notification.body = "Temos algumas ofertas especiais para você"
        notification.banners = banners
        notification.category = "CARROUSSEL"
        notification.carouselType = Categorys.PushCarouselStackInverted.rawValue
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
