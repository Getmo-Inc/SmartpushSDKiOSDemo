//
//  InboxViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 08/01/19.
//  Copyright © 2019 Getmo. All rights reserved.
//

import UIKit
import Kingfisher

struct Extra:Codable {
    // Extra e Payload são objetos com estrutura customisável
    var title: String?
    var message: String?
}
struct Alert:Codable {
    var title: String?
    var body:String?
}
struct Aps:Codable {
    var alert: Alert?
    var category:String?
    var mutablecontent:String?
    enum CodingKeys: String, CodingKey
    {
        case category = "category"
        case mutablecontent = "mutable-content"
        case alert = "alert"
    }
    
    init(alert: Alert? = nil, category: String? = nil, mutablecontent: String? = nil) {
        self.alert = alert
        self.category = category
        self.mutablecontent = mutablecontent
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey: .mutablecontent) {
            mutablecontent = String(value)
        } else {
            mutablecontent = try container.decode(String.self, forKey: .mutablecontent)
        }
    }
    
}
struct Payload:Codable {
    var aps: Aps?
    var mediaURL:String?
    var category:String?
}
struct NotificationsCore:Codable{
    var pushid:String?
    var clicked:Int?
    var payload:Payload?
    var created_at:String?
    var sent_at:String?
    
    enum CodingKeys: String, CodingKey
    {
        case pushid = "pushid"
        case clicked = "clicked"
        case payload = "payload"
        case created_at = "created_at"
        case sent_at = "sent_at"
    }
    
}
struct PostParameters:Encodable{
    var devid:String?
    var appid:String?
    var hwid:String?
    var platform:String?
    var show:String?
    var dateFormat:String?
}

class InboxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var refreshControl: UIRefreshControl!
    @IBOutlet var tableView: UITableView!
    var notifications = [NotificationsCore]()
    var testeCarlos: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
        
        //Add observer get last notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData), name: NSNotification.Name.SmartpushSDKLastNotificationsObtained, object: nil)
        
        //Add observer get extra content
        NotificationCenter.default.addObserver(self, selector: #selector(self.showExtraContent), name: NSNotification.Name.SmartpushSDKExtraContentObtained, object: nil)
        
        SmartpushSDK.sharedInstance().requestLastNotifications()
        
        // Solicitar da SDK as notificações não lidas
        //SmartpushSDK.sharedInstance()?.requestUnreadNotifications()

    }
    
    @objc func showExtraContent(){
        print((SmartpushSDK.sharedInstance().getExtraContent()?.dataString!)!)
    }
    
    @objc func refreshData(){
        refreshControl.beginRefreshing()
        do {
            //let data = SmartpushSDK.sharedInstance().getUnreadNotifications()?.dataResponse!
            let data = SmartpushSDK.sharedInstance().getLastNotifications()?.dataResponse!
            let nots = try JSONDecoder().decode([NotificationsCore].self, from:data!)
            self.notifications = nots
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        } catch let err {
            print("erro ao acessar notificações", err)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.notifications[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: InboxCell.identifier) as? InboxCell {
            
            if let title = obj.payload?.aps?.alert?.title {
                cell.lbTitle.text = title
            }

            if let description = obj.payload?.aps?.alert?.body {
                cell.lbDescription.text = description
            }

            if let bannerImage = obj.payload?.mediaURL {
                let url = URL(string: bannerImage)
                cell.imagebanner.kf.setImage(with: url!)
            }
        
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300.0;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // para marcar a notification como lida
        //let obj = self.notifications[indexPath.row]
        //SmartpushSDK.sharedInstance()?.markPush(asRead: obj.pushid)
        
        let obj = self.notifications[indexPath.row]
        SmartpushSDK.sharedInstance()?.requestExtraContent(for: obj.pushid)
        
    }
    
}
