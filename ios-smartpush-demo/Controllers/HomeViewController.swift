//
//  ViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 11/12/18.
//  Copyright © 2018 Getmo. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lbHardwareId: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lbAliasId: UILabel!
    @IBOutlet weak var spinnerAliasId: UIActivityIndicatorView!
    @IBOutlet weak var spinnerHardwareId: UIActivityIndicatorView!
    @IBOutlet weak var switchDemo: UISwitch!
    @IBOutlet weak var optionTag: UISegmentedControl!
    @IBOutlet weak var tfTagKey: UITextField!
    @IBOutlet weak var tfTagValue: UITextField!
    @IBOutlet weak var swRemoveTag: UISwitch!
    @IBOutlet weak var swBlockUser: UISwitch!
    @IBOutlet weak var lbStatusPush: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowOpacity = 0.5
        SideMenuManager.default.menuEnableSwipeGestures = true
        SideMenuManager.default.menuFadeStatusBar = false
        viewContainer.layer.shadowRadius = 4
        viewContainer.layer.cornerRadius = 4
        swBlockUser.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(addTapped))
        
        //Add observer get device
        NotificationCenter.default.addObserver(self, selector: #selector(self.addedDevice), name: NSNotification.Name.SmartpushSDKDeviceAdded, object: nil)
        
        //Add observer get user info
        NotificationCenter.default.addObserver(self, selector: #selector(self.userInfo), name: NSNotification.Name.SmartpushSDKUserInfoObtained, object: nil)
        
        //Add observer block user
        NotificationCenter.default.addObserver(self, selector: #selector(self.blockUser), name: NSNotification.Name.SmartpushSDKBlockUser, object: nil)
        
    }

    @objc func addedDevice(){
        self.lbAliasId.text = "\(SmartpushSDK.sharedInstance().getDevice().alias ?? "")"
        self.lbHardwareId.text = "\(SmartpushSDK.sharedInstance().getDevice().hwid ?? "")"
        self.spinnerAliasId.stopAnimating()
        self.spinnerHardwareId.stopAnimating()
        
        AppUtils.shared.hwid = SmartpushSDK.sharedInstance().getDevice().hwid
        
        SmartpushSDK.sharedInstance().requestCurretUserInformation()

    }
    
    @objc func userInfo(){
        if let regId = SmartpushSDK.sharedInstance().getUserInfo().regId{
            print(regId)
        }
    }
    
    @objc func blockUser(){
        print("blockUser")
    }

    @objc func addTapped() {
        self.performSegue(withIdentifier: "menu", sender: self)
    }
    
    private func showSuccess(){
        UIAlertView(title: "Success", message: "Solicitação enviada", delegate: nil, cancelButtonTitle: "OK").show()
    }

    @IBAction func sendBlock(_ sender: Any) {
        
        let swh : UISwitch = sender as! UISwitch
        if(swh.isOn){
            SmartpushSDK.sharedInstance().blockUser(false)
            lbStatusPush.text = "ACTIVE"
            let green = UIColor(red: 0, green: 167.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            lbStatusPush.textColor = green
            
        } else {
            lbStatusPush.text = "BLOCKED"
            lbStatusPush.textColor = .red
            SmartpushSDK.sharedInstance().blockUser(true)
        }
        
        showSuccess()
        
    }
}

