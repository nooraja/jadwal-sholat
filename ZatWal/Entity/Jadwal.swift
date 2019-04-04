//
//  EntityJadwal.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.

import Foundation
import UIKit


struct Jadwal: Decodable {
    let title, query, jadwalFor: String?
//    let method: Int?
    let prayerMethodName: String?
//    let daylight: Int?
    let timezone: String?
    let mapImage: String?
    let sealevel: String?
    let todayWeather: TodayWeather?
    let link: String?
    let qiblaDirection, latitude, longitude, address: String?
    let city, state, postalCode, country: String?
    let countryCode: String?
    let items: [Item]?
    let statusValid, statusCode: Int?
    let statusDescription: String?
    
//    enum CodingKeys: String, CodingKey {
//        case title, query
//        case jadwalFor = "for"
//        case method
//        case prayerMethodName = "prayer_method_name"
//        case daylight, timezone
//        case mapImage = "map_image"
//        case sealevel
//        case todayWeather = "today_weather"
//        case link
//        case qiblaDirection = "qibla_direction"
//        case latitude, longitude, address, city, state
//        case postalCode = "postal_code"
//        case country
//        case countryCode = "country_code"
//        case items
//        case statusValid = "status_valid"
//        case statusCode = "status_code"
//        case statusDescription = "status_description"
//    }
}

struct Item: Codable {
    let dateFor, fajr, shurooq, dhuhr: String?
    let asr, maghrib, isha: String?

    enum CodingKeys: String, CodingKey {
        case dateFor = "date_for"
        case fajr, shurooq, dhuhr, asr, maghrib, isha
    }
}

struct TodayWeather: Codable {
    let pressure: Int?
    let temperature: String?
}
