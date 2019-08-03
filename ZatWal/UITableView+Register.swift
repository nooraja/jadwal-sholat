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

	func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
		register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
	}

	func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
		
		guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
			fatalError("Fatal error for cell at \(indexPath)")
		}
		return cell
	}
}


