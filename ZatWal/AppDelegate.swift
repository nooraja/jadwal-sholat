//
//  AppDelegate.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let geoCoder = CLGeocoder()
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = HomeViewController()
		UINavigationBar.appearance().tintColor = .telegramWhite
		UINavigationBar.appearance().barTintColor = .telegramBlue
		UINavigationBar.appearance().titleTextAttributes =
			[.foregroundColor: UIColor.starwarsStarshipGrey]

        return true
    }

}
