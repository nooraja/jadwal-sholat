//
//  SplashScreenViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 04/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit
import CoreLocation

class SplashScreenViewController: UIViewController {
    
    var currentLocation: CLLocation!
    var locManager = CLLocationManager()
    var country: String?
    var isUpdatingLocation = true
    
    
    fileprivate func dataLoad() {
		let collections = Resource<Jadwal>(get: URL(string: "https://muslimsalat.com/\(String(describing: self.country))/daily.json?key=496d474de67f4950ad3119c2c6f96351".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        let latestCollection = collections.map { $0.results.datetime.first?.times }

        URLSession.shared.load(latestCollection) { (res) in
            let fajr = res.map { $0?.fajr }
            let asr = res.map { $0?.asr }
            let dhuhr = res.map {$0?.dhuhr }
            let magrib = res.map {$0?.maghrib }
            let isya = res.map {$0?.isha }
            
            let jadwal: [Schedule] = [
                Schedule(title: fajr as! String),
                Schedule(title: dhuhr as! String),
                Schedule(title: asr as! String),
                Schedule(title: magrib as! String),
                Schedule(title: isya as! String),
            ]
            
            let recentJadwal: [JadwalItem] = [
                .fajr(jadwal[0]),
                .dhuhr(jadwal[1]),
                .asr(jadwal[2]),
                .mahgrib(jadwal[3]),
                .isha(jadwal[4])
            ]
            
			print("location : \(String(describing: self.country))")
            
            let recentItemsVC = ItemsViewController(items: recentJadwal, cellDescriptor: { $0.cellDescriptor })
            recentItemsVC.view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                self.present(recentItemsVC, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
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
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    self.country = pm.locality
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

extension SplashScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR!! locationManager-didFailWithError: \(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
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




let artists: [Artist] = [
    Artist(name: "Prince"),
    Artist(name: "Glen Hansard"),
    Artist(name: "I Am Oak")
]

let albums: [Album] = [
    Album(title: "Blue Lines"),
    Album(title: "Oasem"),
    Album(title: "Bon Iver")
]

enum JadwalItem {
    case fajr(Schedule)
    case dhuhr(Schedule)
    case asr(Schedule)
    case mahgrib(Schedule)
    case isha(Schedule)
}



enum RecentItem {
    case artist(Artist)
    case album(Album)
}

let recentItems: [RecentItem] = [
    .artist(artists[0]),
    .artist(artists[1]),
    .album(albums[1])
]

struct Schedule {
    var title: String
}

struct Album {
    var title: String
}

struct Artist {
    var name: String
}

extension Schedule {
    func configureCell(_ cell: JadwalCell) {
        cell.textLabel?.text = title
    }
}

extension Artist {
    func configureCell(_ cell: ArtistCell) {
        cell.textLabel?.text = name
    }
}

extension Album {
    func configureCell(_ cell: AlbumCell) {
        cell.textLabel?.text = title
    }
}


final class JadwalCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JadwalItem {
    var cellDescriptor: CellDescriptor {
        switch self {
        case .fajr(let fajr):
            return CellDescriptor(reuseIdentifier: "fajr", configure: fajr.configureCell)
        case .dhuhr(let dhuhr):
            return CellDescriptor(reuseIdentifier: "dhuhr", configure: dhuhr.configureCell)
        case .asr(let asr):
            return CellDescriptor(reuseIdentifier: "asr", configure: asr.configureCell)
        case .mahgrib(let mahgrib):
            return CellDescriptor(reuseIdentifier: "mahgrib", configure: mahgrib.configureCell)
        case .isha(let isha):
            return CellDescriptor(reuseIdentifier: "isha", configure: isha.configureCell)
        }
    }
    
}

extension RecentItem {
    var cellDescriptor: CellDescriptor {
        switch self {
        case .artist(let artist):
            return CellDescriptor(reuseIdentifier: "artist", configure: artist.configureCell)
        case .album(let album):
            return CellDescriptor(reuseIdentifier: "album", configure: album.configureCell)
        }
    }
}
