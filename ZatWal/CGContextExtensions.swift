//
//  CGContextExtensions.swift
//  ZatWal
//
//  Created by Muhammad Noor on 28/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

extension CGContext {
	func drawLinearGradient(
		in rect: CGRect,
		startingWith startColor: CGColor,
		finishingWith endColor: CGColor
		) {
		// 1
		let colorSpace = CGColorSpaceCreateDeviceRGB()

		// 2
		let locations = [0.0, 1.0] as [CGFloat]

		// 3
		let colors = [startColor, endColor] as CFArray

		// 4
		guard let gradient = CGGradient(
			colorsSpace: colorSpace,
			colors: colors,
			locations: locations
			) else {
				return
		}

		// 5
		let startPoint = CGPoint(x: rect.midX, y: rect.minY)
		let endPoint = CGPoint(x: rect.midX, y: rect.maxY)

		// 6
		saveGState()

		// 7
		addRect(rect)
		clip()
		drawLinearGradient(
			gradient,
			start: startPoint,
			end: endPoint,
			options: CGGradientDrawingOptions()
		)

		restoreGState()
	}
}
