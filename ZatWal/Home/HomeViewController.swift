//
//  HomeViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

protocol Reusable {
}


class AppCell: UITableViewCell {
    
}

extension UITableViewCell: Reusable {
    static var reusedID: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reusedID)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reusedID, for: indexPath) as? Cell else { fatalError("Fatal error for cell at \(indexPath)")
            
        }
        return cell
    }
}

class HomeViewController: UITableViewController, UITextFieldDelegate {
    
    var eJadwal: Jadwal?
    var num: [Item]?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataLoad()
    }
    
    override func viewDidLoad() {
        self.dataLoad()
        tableView.registerCell(AppCell.self )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func dataLoad()  {
        guard let url = URL(string: "https://muslimsalat.com/indonesia/daily.json?key=496d474de67f4950ad3119c2c6f96351") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let datas = data else { return }
            
            do {
                let course = try JSONDecoder().decode(Jadwal.self, from: datas)
                print(course)
                DispatchQueue.main.async {
                    self.eJadwal = course
                    self.tableView.reloadData()
                }
            } catch let jsonErr {
                print("Error Serilization json:", jsonErr)
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AppCell
        cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Fajr        : \(self.eJadwal?.items?.first?.fajr ?? "")"
        case 1:
            cell.textLabel?.text = "Dhuhr       : \(self.eJadwal?.items?.first?.dhuhr ?? "")"
        case 2:
            cell.textLabel?.text = "Asr         : \(self.eJadwal?.items?.first?.asr ?? "")"
        case 3:
            cell.textLabel?.text = "Magrib      : \(self.eJadwal?.items?.first?.maghrib ?? "")"
        case 4:
            cell.textLabel?.text = "Isha        : \(self.eJadwal?.items?.first?.isha ?? "")"
        default:
            return AppCell()
        }
        return cell
    }
}


