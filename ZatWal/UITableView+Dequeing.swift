//
//  UITableView+Dequeing.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/06/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

extension UITableView {

	// MARK: - Public Methods

	func dequeueReusableCell<T: UITableViewCell>(for indexPath:  IndexPath) -> T {

		guard let cell =  dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Failed to dequeu cell \(T.reuseIdentifier)")
		}

		return cell
	}
}
