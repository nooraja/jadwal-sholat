//
//  MainViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 10/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import Foundation
import UIKit

struct CellDescriptor {
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configure: (UITableViewCell) -> ()
    
    init<Cell: UITableViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()) {
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}


final class ItemsViewController<Item>: UITableViewController {
    var items: [Item] = []
    let cellDescriptor: (Item) -> CellDescriptor
    var didSelect: (Item) -> () = { _ in }
    var reuseIdentifiers: Set<String> = []
    
    init(items: [Item], cellDescriptor: @escaping (Item) -> CellDescriptor) {
        self.cellDescriptor = cellDescriptor
        super.init(style: .plain)
        self.items = items

		self.tableView.tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)
        
        if !reuseIdentifiers.contains(descriptor.reuseIdentifier) {
            tableView.register(descriptor.cellClass, forCellReuseIdentifier: descriptor.reuseIdentifier)
            reuseIdentifiers.insert(descriptor.reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }
}
