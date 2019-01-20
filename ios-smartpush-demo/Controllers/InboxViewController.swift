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
}
struct Alert:Codable {
    var title: String?
    var body:String?
}
struct Aps:Codable {
    var alert: Alert?
    var category:String?
    var mutablecontent:Int?
    enum CodingKeys: String, CodingKey
    {
        case category = "category"
        case mutablecontent = "mutable-content"
        case alert = "alert"
    }
}
struct Payload:Codable {
    var aps: Aps?
    var mediaURL:String?
    var category:String?
}
struct Notification:Codable{
    var pushid:String?
    var clicked:Int?
    var payload:Payload?
    var extra:Extra?
    var created_at:String?
    var sent_at:String?
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
    
    @IBOutlet weak var spinnerInbox: UIActivityIndicatorView!
    var notifications = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 44.0
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
       
    }
    
    @objc func refreshData() {
        refreshControl.beginRefreshing()
        fetchLastNotifications { (nots) in
            let slice = nots.prefix(10)
            self.notifications = Array(slice)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    fileprivate func fetchLastNotifications (completion: @escaping ([Notification]) -> ()) {
        
        let urlString = "https://api.getmo.com.br/notifications/last"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            var post = PostParameters()
            post.devid = "CN6Z8Eka3FSQ9IA"
            post.appid = "D0177E40654CD3D"
            post.hwid = AppUtils.shared.hwid
            post.platform = "iOS"
            post.show = "all"
            
            let params = try JSONEncoder().encode(post.self)
            request.httpBody = params
        } catch let jsonEncodeErr {
            print("Erro ao serializar o json", jsonEncodeErr)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            guard let data = data else {return}
            
            do {
                let notifications = try JSONDecoder().decode([Notification].self, from:data)
                completion(notifications)
            } catch let err {
                print("erro ao acessar notificações", err)
            }
            
        }.resume()
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
}
