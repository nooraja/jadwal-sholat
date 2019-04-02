//
//  HomeViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 40
        tableView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return cell
    }
}
