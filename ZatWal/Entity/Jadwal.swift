//
//  EntityJadwal.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.

import Foundation

struct Jadwal: Codable {
    let title, query, jadwalFor: String?
    let method: Int?
    let prayerMethodName: String?
    let daylight, timezone: Int?
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
        case method
        case prayerMethodName = "prayer_method_name"
        case daylight, timezone
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

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func jadwalTask(with url: URL, completionHandler: @escaping (Jadwal?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
