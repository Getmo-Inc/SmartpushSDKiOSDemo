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
    
    //@IBOutlet weak var environmentSeg: UISegmentedControl!
    
    @IBOutlet weak var lbHardwareId: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lbAliasId: UILabel!
    @IBOutlet weak var spinnerAliasId: UIActivityIndicatorView!
    @IBOutlet weak var spinnerHardwareId: UIActivityIndicatorView!
    //@IBOutlet weak var lbRegisterId: UILabel!
    //@IBOutlet weak var spinnerRegisterId: UIActivityIndicatorView!
    @IBOutlet weak var switchDemo: UISwitch!
    @IBOutlet weak var optionTag: UISegmentedControl!
    @IBOutlet weak var tfTagKey: UITextField!
    @IBOutlet weak var tfTagValue: UITextField!
    @IBOutlet weak var swRemoveTag: UISwitch!
    @IBOutlet weak var swBlockUser: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowOpacity = 0.5
        SideMenuManager.default.menuEnableSwipeGestures = true
        SideMenuManager.default.menuFadeStatusBar = false
        viewContainer.layer.shadowRadius = 4
        viewContainer.layer.cornerRadius = 4
        viewContainer.isUserInteractionEnabled = false
        switchDemo.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
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

}

