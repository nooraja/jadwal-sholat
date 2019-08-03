//
//  UITableViewCell+ReuseIdentifier.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/06/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

extension UITableViewCell {

	// MARK: - Public Methods

	static var reuseIdentifier: String {
		return String(describing: self)
	}

	static var nib: UINib {
		return UINib(nibName: reuseIdentifier, bundle: nil)
	}
}
