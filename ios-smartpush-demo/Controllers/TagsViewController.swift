//
//  TagsViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 07/01/19.
//  Copyright © 2019 Getmo. All rights reserved.
//

import UIKit

/**
 * Neste exemplo foi utilizada uma TAG do tipo LIST.
 * As TAGs devem ser criadas primeiramente no painel SMARTPUSH antes que possam ser utilizadas.
 * https://admin.getmo.com.br/tags
 *
 * Os tipos de TAGs são: LIST, STRING, DATE, NUMBER, e BOOLEAN.
 */

class TagsViewController: UIViewController {
    
    @IBOutlet weak var switchPolitics: UISwitch!
    @IBOutlet weak var switchEconomy: UISwitch!
    @IBOutlet weak var switchSports: UISwitch!
    @IBOutlet weak var viewTags: UIView!
    @IBOutlet weak var spinnerTags: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshTags()
    }
    
    func refreshTags(){
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            let tags = (SmartpushSDK.sharedInstance()?.getStringForTag("NEWS_FEED_TAGS"))
            
            DispatchQueue.main.async {
                self.viewTags.isHidden = false
                self.switchSports.isOn = (tags?.contains("ESPORTE"))!
                self.switchEconomy.isOn = (tags?.contains("ECONOMIA"))!
                self.switchPolitics.isOn = (tags?.contains("POLITICA"))!
                self.spinnerTags.stopAnimating()
            }

        }
        
    }
    
    
    @IBAction func switchEconomyValueChange(_ sender: Any) {
    
        if switchEconomy.isOn {
            Tags.updateTagEconomy(true)
            SmartpushSDK.sharedInstance()?.setArray(["ECONOMIA"], forTag: "NEWS_FEED_TAGS")
        } else {
            Tags.updateTagEconomy(false)
            SmartpushSDK.sharedInstance()?.delArray(["ECONOMIA"], forTag: "NEWS_FEED_TAGS")
        }
        
    }
    @IBAction func switchPoliticsValueChange(_ sender: Any) {
    
        if switchPolitics.isOn {
            Tags.updateTagPolitics(true)
            SmartpushSDK.sharedInstance()?.setArray(["POLITICA"], forTag: "NEWS_FEED_TAGS")
        } else {
            Tags.updateTagPolitics(false)
            SmartpushSDK.sharedInstance()?.delArray(["POLITICA"], forTag: "NEWS_FEED_TAGS")
        }
        
    }
    @IBAction func switchSportsValueChange(_ sender: Any) {

        if switchSports.isOn {
            Tags.updateTagSports(true)
            SmartpushSDK.sharedInstance()?.setArray(["ESPORTE"], forTag: "NEWS_FEED_TAGS")
        } else {
            Tags.updateTagSports(false)
            SmartpushSDK.sharedInstance()?.delArray(["ESPORTE"], forTag: "NEWS_FEED_TAGS")
        }
        
    }
    
    @IBAction func sendTag(_ sender: UIButton) {
        SmartpushSDK.sharedInstance()?.delArray(["ECONOMIA"], forTag: "NEWS_FEED_TAGS")
        SmartpushSDK.sharedInstance()?.delArray(["POLITICA"], forTag: "NEWS_FEED_TAGS")
        SmartpushSDK.sharedInstance()?.delArray(["ESPORTE"], forTag: "NEWS_FEED_TAGS")
        
        switchSports.isOn = false
        switchEconomy.isOn = false
        switchPolitics.isOn = false
        
        Tags.updateTagPolitics(false)
        Tags.updateTagSports(false)
        Tags.updateTagEconomy(false)
    }

}
