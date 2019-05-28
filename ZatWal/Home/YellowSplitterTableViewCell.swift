//
//  YellowSplitterTableViewCell.swift
//  ZatWal
//
//  Created by Muhammad Noor on 28/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class YellowSplitterTableViewCell: UITableViewCell {
	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		let y = bounds.maxY - 0.5
		let minX = bounds.minX
		let maxX = bounds.maxX

		context.setStrokeColor(UIColor.telegramBlue.cgColor)
		context.setLineWidth(1.0)
		context.move(to: CGPoint(x: minX, y: y))
		context.addLine(to: CGPoint(x: maxX, y: y))
		context.strokePath()
	}
}
