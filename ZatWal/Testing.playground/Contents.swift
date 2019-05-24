import UIKit


//
//  EntityJadwal.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.

import Foundation
import UIKit

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



URLSession.shared.dataTask(with: URL(string: "https://api.pray.zone/v2/times/today.json?city=jakarta")!) { (data, response, error) in

	guard let data = data else {
		return
	}

	do {
		let decodeData = try JSONDecoder().decode(Jadwal.self, from: data)

		print(decodeData)
	} catch  {

	}



}.resume()



