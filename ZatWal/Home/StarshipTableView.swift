//
//  StarshipTableView.swift
//  ZatWal
//
//  Created by Muhammad Noor on 28/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class StarshipTableView: UITableView {
	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		let backgroundRect = bounds
		context.drawLinearGradient(
			in: backgroundRect,
			startingWith: UIColor.telegramWhite.cgColor,
			finishingWith: UIColor.black.cgColor
		)
	}
}
