//
//  SideMenuTableViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 14/12/18.
//  Copyright © 2018 Getmo. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        return cell
    }


}
