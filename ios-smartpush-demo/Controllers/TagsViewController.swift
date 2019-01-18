//
//  TagsViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 07/01/19.
//  Copyright © 2019 Getmo. All rights reserved.
//

import UIKit

class TagsViewController: UIViewController {

    @IBOutlet weak var switchPolitics: UISwitch!
    @IBOutlet weak var switchEconomy: UISwitch!
    
    @IBOutlet weak var switchSports: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func refreshTags(){
        
    }
    
    @IBAction func sendTag(_ sender: UIButton) {
        
        if switchPolitics.isOn {
                SmartpushSDK.sharedInstance().setString("POLITICA", forTag: "NEWS_FEED_IOS")
        } else {
                SmartpushSDK.sharedInstance()?.delString("POLITICA", forTag: "NEWS_FEED_IOS")
        }
        
        if switchEconomy.isOn {
            SmartpushSDK.sharedInstance().setString("ECONOMIA", forTag: "NEWS_FEED_IOS")
        } else {
            SmartpushSDK.sharedInstance()?.delString("ECONOMIA", forTag: "NEWS_FEED_IOS")
        }
        
        if switchEconomy.isOn{
            SmartpushSDK.sharedInstance().setString("ESPORTE", forTag: "NEWS_FEED_IOS")
        } else {
            SmartpushSDK.sharedInstance()?.delString("ESPORTE", forTag: "NEWS_FEED_IOS")
        }
        
        
    }

}
