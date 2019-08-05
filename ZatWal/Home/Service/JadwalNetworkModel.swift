//
//  JadwalNetworkModel.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import Foundation
import RxSwift

struct JadwalNetworkModel {

	private let provider: Provider<JadwalEndpoint>

	init(provider: Provider<JadwalEndpoint> = Provider<JadwalEndpoint>() ) {
		self.provider = provider
	}

	func retreiveJadwal(city: String) -> Observable<Jadwal> {

		return provider.request(endpoint: .jadwal(name: city)).map(to: Jadwal.self)
	}
}


extension Observable where Element == Response {

	func map<T: Decodable>(to type: T.Type) -> Observable<T> {
		return self.map{ (response: Response) throws -> T in

			guard let data = response.data, let result = try? JSONDecoder().decode(T.self, from: data) else {
				throw APIError.decodeError
			}

			return result
		}
	}
}
