//
//  StarshipsListCellBackground.swift
//  ZatWal
//
//  Created by Muhammad Noor on 28/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class StarshipsListCellBackground: UIView {

	override func draw(_ rect: CGRect) {

		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		let backgroundRect = bounds
		context.drawLinearGradient(
			in: backgroundRect,
			startingWith: UIColor.telegramBlue.cgColor,
			finishingWith: UIColor.telegramWhite.cgColor
		)

		let strokeRect = backgroundRect.insetBy(dx: 4.5, dy: 4.5)
		context.setStrokeColor(UIColor.telegramWhite.cgColor)
		context.setLineWidth(1)
		context.stroke(strokeRect)
	}

	// ... many lines later

	func drawBlueCircle(in context: CGContext) {
		context.saveGState()
		context.setFillColor(UIColor.telegramWhite.cgColor)
		context.addEllipse(in: bounds)
		context.drawPath(using: .fill)
		context.restoreGState()
	}
}
