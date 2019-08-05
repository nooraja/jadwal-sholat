//
//  JadwalEndpoint.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import Foundation

enum JadwalEndpoint {
	case jadwal(name: String)
}

extension JadwalEndpoint: EndpointType {

	var method: HTTPMethod {
		return .get
	}

	var baseUrl: URL {
		return URL(string: "https://api.pray.zone")!
	}

	var path: String {
		switch self {
		case .jadwal:
			return "/v2/times/today.json?"
		}
	}

	var parameter: [String : Any] {
		switch self {
		case .jadwal(let name):
			return ["city" : name]
		}
	}
}
