//
//  Provider.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import RxSwift
import RxCocoa

struct Response {

	let data: Data?
	let response: URLResponse?
}

struct Provider<Endpoint: EndpointType> {

	func request(endpoint: Endpoint) -> Observable<Response> {

		var components = URLComponents(url: endpoint.baseUrl, resolvingAgainstBaseURL: true)
		components?.path = endpoint.path
		components?.queryItems = endpoint.parameter.map{ parameter -> URLQueryItem in
			return URLQueryItem(name: parameter.key, value: String(describing: parameter.value))
		}

		guard let url = components?.url else {
			return Observable.empty()
		}

		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue

		return URLSession.shared.rx.response(request: request).map{ response, data in
			return Response(data: data, response: response)
		}
	}
}
