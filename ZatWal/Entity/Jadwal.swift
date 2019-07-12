//
//  EntityJadwal.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.

import Foundation

// MARK: - Jadwal
struct Jadwal: Codable {
	let code: Int
	let status: String
	let results: Results
}

// MARK: - Results
struct Results: Codable {
	let datetime: [Datetime]
	let location: Locations
}

struct Jadwal: Decodable {
    let title, query, jadwalFor: String?
    let prayerMethodName: String?
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
    
    enum CodingKeys: String, CodingKey {
        case title, query
        case jadwalFor = "for"
        case prayerMethodName = "prayer_method_name"
        case timezone
        case mapImage = "map_image"
        case sealevel
        case todayWeather = "today_weather"
        case link
        case qiblaDirection = "qibla_direction"
        case latitude, longitude, address, city, state
        case postalCode = "postal_code"
        case country
        case countryCode = "country_code"
        case items
        case statusValid = "status_valid"
        case statusCode = "status_code"
        case statusDescription = "status_description"
    }
}

// MARK: - Datetime
struct Datetime: Codable {
	let times: Times
	let date: DateClass
}

// MARK: - DateClass
struct DateClass: Codable {
	let timestamp: Int
	let gregorian, hijri: String
}

// MARK: - Times
struct Times: Codable {
	let imsak, sunrise, fajr, dhuhr: String
	let asr, sunset, maghrib, isha: String
	let midnight: String

	enum CodingKeys: String, CodingKey {
		case imsak = "Imsak"
		case sunrise = "Sunrise"
		case fajr = "Fajr"
		case dhuhr = "Dhuhr"
		case asr = "Asr"
		case sunset = "Sunset"
		case maghrib = "Maghrib"
		case isha = "Isha"
		case midnight = "Midnight"
	}
}

// MARK: - Location
struct Locations: Codable {
	let latitude, longitude: Double
	let elevation: Int
	let city, country, countryCode, timezone: String
	let localOffset: Int

	enum CodingKeys: String, CodingKey {
		case latitude, longitude, elevation, city, country
		case countryCode = "country_code"
		case timezone
		case localOffset = "local_offset"
	}
}
