//
//  SplashScreenViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 04/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit


class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let recentItemsVC = ItemsViewController(items: recentItems, cellDescriptor: { $0.cellDescriptor })
        
        let collections = Resource<Jadwal>(get: URL(string: "https://muslimsalat.com/jakarta/daily.json?key=496d474de67f4950ad3119c2c6f96351")!)
        
        let latestCollection = collections.map { $0.items?.first }
        
        URLSession.shared.load(latestCollection) { print($0) }
        
        
//        recentItemsVC.view.frame = view.bounds

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.present(recentItemsVC, animated: true, completion: nil)
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
    case fajr
    case dhuhr
    case asr
    case mahgrib
    case isha
}

enum RecentItem {
    case artist(Artist)
    case album(Album)
}

let recentJadwal: [Item] = [Item.init(dateFor: "", fajr: "String?", shurooq: "String", dhuhr: "String", asr: "String?", maghrib: "String?", isha: "String?")]


let recentItems: [RecentItem] = [
    .artist(artists[0]),
    .artist(artists[1]),
    .album(albums[1])
]

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
