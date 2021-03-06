//
//  HomeViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//


import UIKit
import CoreLocation

class AppCell: UITableViewCell { }

class HomeViewController: UITableViewController, UITextFieldDelegate {
    
    var eJadwal: Jadwal?
    var num: [Results]?
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

		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.isScrollEnabled = false
		tableView.estimatedRowHeight = 300
		tableView.tableFooterView = UIView()
		tableView.backgroundView = StarshipsListCellBackground(frame: .zero)

		tableView.registerCell(AppCell.self)
		tableView.registerCell(HomeHeaderCell.self)
    }
    
    func dataLoad()  {
		guard let url = URL(string: "https://api.pray.zone/v2/times/today.json?city=\(self.country ?? "")"
			.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(Jadwal.self, from: data)
                
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
        locManager.stopUpdatingLocation()
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!

        let lon: Double = Double("\(pdblLongitude)")!

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
				guard let pm = placemarks else { return }
                
                if pm.count > 0 {

					let subAdmin = placemarks?.first?.administrativeArea
					self.country = subAdmin

                    self.dataLoad()
                }
        })
    }

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 {
			return 5
		} else {
			return 1
		}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as HomeHeaderCell
			cell.layoutIfNeeded()
			cell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 400))
			cell.backgroundColor = .clear
			cell.selectionStyle = .none

			cell.userEmail.text = "\(self.country ?? "")"
			let format = DateFormatter()
			format.timeStyle = .medium

			let timer = Timer(timeInterval: 1.0, repeats: true, block: { _ in
				cell.userFullName.text = format.string(from: Date())
			})

			RunLoop.current.add(timer, forMode: .common)

			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AppCell
			cell.backgroundColor = .clear

			cell.selectionStyle = .none
			cell.textLabel!.textColor = .telegramBlue

			switch indexPath.row {
			case 0:
				cell.textLabel?.text = "Fajr        : \(self.eJadwal?.results.datetime.first?.times.fajr ?? "")"
				return cell
			case 1:
				cell.textLabel?.text = "Dhuhr       : \(self.eJadwal?.results.datetime.first?.times.dhuhr ?? "")"
				return cell
			case 2:
				cell.textLabel?.text = "Asr         : \(self.eJadwal?.results.datetime.first?.times.asr ?? "")"
				return cell
			case 3:
				cell.textLabel?.text = "Magrib      : \(self.eJadwal?.results.datetime.first?.times.maghrib ?? "")"
				return cell
			case 4:
				cell.textLabel?.text = "Isha        : \(self.eJadwal?.results.datetime.first?.times.isha ?? "")"
				return cell
			default:
				return AppCell()
			}
		default:
			return UITableViewCell()
		}

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
