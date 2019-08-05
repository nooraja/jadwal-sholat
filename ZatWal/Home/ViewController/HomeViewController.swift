//
//  HomeViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//


import UIKit
import CoreLocation
import RxSwift

class HomeViewController: UITableViewController {
    
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

		bindViewModel()
		tableView.registerCell(AppCell.self)
		tableView.registerCell(HomeHeaderCell.self)
    }

	private var viewModel: JadwalViewModel?
	private let disposeBag = DisposeBag()

	convenience init(viewModel: JadwalViewModel) {
		self.init()

		self.viewModel = viewModel
	}

	private func updateMovieDetail() {

		tableView.reloadData()
		tableView.tableFooterView = UIView()
	}

	func bindViewModel() {

		viewModel?.reloadDataObservable.subscribe(onNext: { [weak self] in
			self?.tableView.reloadData()
		}).disposed(by: disposeBag)

		viewModel?.showErrorObservable.subscribe(onNext: { [weak self] (error: Error) in
			print(error.localizedDescription)
		})
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

                    self.bindViewModel()
                }
        })
    }

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		guard let count = viewModel?.getNumberOfRows(forSection: section) else {
			return 0
		}

		return count
    }

	private func createHeaderCell(for indexPath: IndexPath) -> HomeHeaderCell {

		let cell =  tableView.dequeueReusableCell(for: indexPath) as HomeHeaderCell

		if let data = viewModel?.getDetailJadwalHeaderViewModel() {
			cell.bind(title: data.name ?? "")
		}

		return cell
	}

	private func createInfoCell(for indexPath: IndexPath) -> AppCell {

		let cell =  tableView.dequeueReusableCell(for: indexPath) as AppCell

		if let data = viewModel?.getDetailJadwalCellViewModel(atIndex: indexPath.row) {
			cell.bind(title: data.time ?? "", subtitle: "")
		}

		return cell
	}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		switch JadwalViewModel.Section(rawValue: indexPath.section) {
		case .some(.header):
			return createHeaderCell(for: indexPath)

		case .some(.cell):
			return createInfoCell(for: indexPath)

		case .none:
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
