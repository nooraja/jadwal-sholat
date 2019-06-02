//
//  UITableView+Register.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/06/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

extension UITableView {

	// MARK: - Public Methods

	func register<T: UITableViewCell>(_ type: T.Type) {
		register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
	}
}


