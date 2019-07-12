//
//  EntityJadwal.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.

import Foundation

// MARK: - Jadwal
struct Jadwal: Codable {

	// MARK: - Results
	struct Results: Codable {

		// MARK: - Datetime
		struct Datetime: Codable {

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

			let times: Times
			let date: DateClass
		}

		// MARK: - Location
		struct Location: Codable {
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

		// MARK: - Settings
		struct Settings: Codable {
			let timeformat, school, juristic, highlat: String
			let fajrAngle, ishaAngle: Int

			enum CodingKeys: String, CodingKey {
				case timeformat, school, juristic, highlat
				case fajrAngle = "fajr_angle"
				case ishaAngle = "isha_angle"
			}
		}

		let datetime: [Datetime]
		let location: Location
		let settings: Settings

	}

	let code: Int
	let status: String
	let results: Results

}
