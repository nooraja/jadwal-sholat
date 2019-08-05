//
//  JadwalViewModel.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import Foundation
import RxSwift

final class JadwalViewModel {

	enum Section: Int {
		case header
		case cell
	}

	var reloadDataObservable: Observable<Void> {
		return reloadDataSubject
			.asObservable()
			.observeOn(MainScheduler.instance)
	}

	var showErrorObservable: Observable<Error> {
		return showErrorSubject
			.asObservable()
			.observeOn(MainScheduler.instance)
	}

	private var jadwalDetailViewModel = [JadwalCellViewModel]()
	private var jadwalHeaderViewModel: JadwalHeaderViewModel?

	private let networkModel: JadwalNetworkModel?
	private let disposeBag = DisposeBag()

	private let reloadDataSubject = PublishSubject<Void>()
	private let showErrorSubject = PublishSubject<Error>()

	init(networkModel: JadwalNetworkModel) {
		self.networkModel = networkModel
	}

	func retreiveJadwal(city: String) {

		networkModel?.retreiveJadwal(city: city).subscribe(onNext: { [weak self] (jadwal: Jadwal) in

			guard let times = jadwal.results.datetime.first?.times else {
				return
			}

			self?.jadwalDetailViewModel.append(contentsOf: [
				JadwalCellViewModel(time: times.fajr),
				JadwalCellViewModel(time: times.dhuhr),
				JadwalCellViewModel(time: times.asr),
				JadwalCellViewModel(time: times.maghrib),
				JadwalCellViewModel(time: times.isha)
				])

			self?.jadwalHeaderViewModel = JadwalHeaderViewModel(name: city)

			self?.reloadDataSubject.onNext(())

			}, onError: { [weak self] (error: Error) in
				self?.showErrorSubject.onNext(error)
			})
			.disposed(by: disposeBag)
	}

	func getNumberOfRows(forSection section: Int) -> Int {

		switch Section(rawValue: section) {
		case .some(.header):
			return 1

		case .some(.cell):
			return jadwalDetailViewModel.count

		case .none:
			return 0
		}
	}

	func getDetailJadwalHeaderViewModel() -> JadwalHeaderViewModel? {
		return jadwalHeaderViewModel
	}

	func getDetailJadwalCellViewModel(atIndex index: Int) -> JadwalCellViewModel? {

		guard index < jadwalDetailViewModel.count else {
			return nil
		}

		return jadwalDetailViewModel[index]
	}
}
