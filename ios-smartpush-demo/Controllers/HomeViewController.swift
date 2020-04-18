//
//  ViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 11/12/18.
//  Copyright © 2018 Getmo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lbHardwareId: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lbAliasId: UILabel!
    @IBOutlet weak var spinnerAliasId: UIActivityIndicatorView!
    @IBOutlet weak var spinnerHardwareId: UIActivityIndicatorView!
    @IBOutlet weak var swBlockUser: UISwitch!
    @IBOutlet weak var lbStatusPush: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet  weak var leadingC: NSLayoutConstraint!
    @IBOutlet  weak var trailingC: NSLayoutConstraint!
    
    let objectArray = ["Tags", "Geofence", "Inbox", "Notificações", "Notificações Locais"]

    var urlString:String?
    var menuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        leadingC.constant = 0
        
        viewContainer.layer.shadowRadius = 4
        viewContainer.layer.cornerRadius = 4
        swBlockUser.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
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

    @IBAction func menuButton(_ sender: Any) {
        
        if !menuVisible {
            leadingC.constant = 250
            trailingC.constant = 250
            menuVisible = true
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {self.view.layoutIfNeeded()
            }) {(animationComplete) in
                print("Animation completed!")
            }
        } else {
            leadingC.constant = 0
            trailingC.constant = 0
            menuVisible = false
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {self.view.layoutIfNeeded()
            }) {(animationComplete) in
                print("Animation completed!")
            }
        }
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell") as? MenuTableViewCell {
            cell.menuLabel.text = self.objectArray[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch self.objectArray[indexPath.row] {
            case "Tags":
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "tagsViewController") as! TagsViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(newViewController, animated: true)
            case "Geofence":
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "geofenceViewController") as! GeofenceViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(newViewController, animated: true)
            case "Inbox":
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "inboxViewController") as! InboxViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(newViewController, animated: true)
            case "Notificações":
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "notificationTypesViewController") as! NotificationTypesViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(newViewController, animated: true)
            default:
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "localNotificationViewController") as! LocalNotificationViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
}

