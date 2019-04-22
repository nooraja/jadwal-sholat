//
//  HomeViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//


import UIKit
import CoreLocation

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
    var currentLocation: CLLocation!
    var locManager = CLLocationManager()
    var country: String?
    var isUpdatingLocation = true
    var lastLocationError: Error?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 9, *) {
            locManager.allowsBackgroundLocationUpdates = true
        }
        locManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        tableView.registerCell(AppCell.self )
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func dataLoad()  {
        guard let url = URL(string: "https://muslimsalat.com/\(self.country ?? "")/daily.json?key=496d474de67f4950ad3119c2c6f96351".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        
        print("url \(url)")
        
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
    
    func stopLocationManager() {
        //        isUpdatingLocation = false
        locManager.stopUpdatingLocation()
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                guard let pm = placemarks as? [CLPlacemark] else {return }
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    self.country = pm.locality
                    print("country \(self.country)")
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                }
        })
        self.dataLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AppCell
        cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            cell.textLabel?.text = "\(self.country ?? "") time : \(hour):\(minutes)"
            cell.accessoryType = .checkmark
        case 1:
            cell.textLabel?.text = "Fajr        : \(self.eJadwal?.items?.first?.fajr ?? "")"
        case 2:
            cell.textLabel?.text = "Dhuhr       : \(self.eJadwal?.items?.first?.dhuhr ?? "")"
        case 3:
            cell.textLabel?.text = "Asr         : \(self.eJadwal?.items?.first?.asr ?? "")"
        case 4:
            cell.textLabel?.text = "Magrib      : \(self.eJadwal?.items?.first?.maghrib ?? "")"
            return cell
        case 5:
            cell.textLabel?.text = "Isha        : \(self.eJadwal?.items?.first?.isha ?? "")"
        default:
            return AppCell()
        }
        return cell
    }
    
    private func updateLoc() {
        if isUpdatingLocation {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locManager.requestWhenInUseAuthorization()
            }else{
                locManager.startUpdatingLocation()
            }
        }
    }
}
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR!! locationManager-didFailWithError: \(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        lastLocationError = error
        stopLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        currentLocation = locations.first!
        
        print("Got It location: \(locations.description)")
        DispatchQueue.main.async {
            self.getAddressFromLatLon(pdblLatitude: "\(self.currentLocation.coordinate.latitude )", withLongitude: "\(self.currentLocation.coordinate.longitude)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        if status == .notDetermined {
            print("Req Auth")
            locManager.requestWhenInUseAuthorization()
        }else if status == .denied || status == .restricted {
            print("Denied or Restricted")
        }else {
            updateLoc()
            locManager.startUpdatingLocation()
        }
    }
}
