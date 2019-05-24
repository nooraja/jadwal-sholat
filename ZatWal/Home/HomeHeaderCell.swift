//
//  HomeHeaderCell.swift
//  ZatWal
//
//  Created by Muhammad Noor on 23/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

	let mainView: UIView = {
		let vw = UIView(frame: .zero)
		vw.translatesAutoresizingMaskIntoConstraints = false

		return vw
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		addSubview(mainView)
		mainView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
