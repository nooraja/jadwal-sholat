//
//  EndpointType.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import Foundation
import RxSwift

protocol EndpointType {

	var baseUrl: URL { get }
	var path: String { get }
	var parameter: [String: Any] { get }
	var header: [String: Any] { get }
	var method: HTTPMethod { get }
}

extension EndpointType {

	var header: [String: Any] {
		return [:]
	}

	var parameter: [String: Any] {
		return [:]
	}

}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case delete = "DELETE"
	case put = "PUT"
	case patch = "PATCH"
}
