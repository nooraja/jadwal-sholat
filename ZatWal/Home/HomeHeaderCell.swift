//
//  HomeHeaderCell.swift
//  ZatWal
//
//  Created by Muhammad Noor on 23/05/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

	var frameWidth: CGFloat = 400
	let frameHeight: CGFloat = 250
	let frameCut: CGFloat = 50

	let cellView: UIView = {
		let vw = UIView()

		return vw
	}()

	lazy var profileImage: UIImageView = {

		let image = UIImageView()
		image.image = #imageLiteral(resourceName: "ic_home")
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 80 / 2
		image.layer.masksToBounds = true
		image.isUserInteractionEnabled = true
		image.clipsToBounds = true

		return image
	}()

	lazy var headerImageView: UIImageView = {

		let image = UIImageView()
		image.image = #imageLiteral(resourceName: "glue")
		image.contentMode = .scaleAspectFill
//		image.layer.cornerRadius = 80 / 2
		image.layer.masksToBounds = true
		image.isUserInteractionEnabled = true
		image.clipsToBounds = true

		return image
	}()

	lazy var userEmail: UILabel = {
		let label = UILabel()
		label.text = "noor.aja@mail.com"
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

		return label
	}()

	lazy var userFullName: UILabel = {
		let label = UILabel()
		label.text = "noor.aja@mail.com"
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

		return label
	}()

	private func setupUIElement() {

		let cutDirection = UIBezierPath()
		cutDirection.move(to: CGPoint(x: 0, y: 0))
		cutDirection.addLine(to: CGPoint(x: frameWidth, y: 0))
		cutDirection.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
		cutDirection.addLine(to: CGPoint(x: 0, y: frameWidth + frameCut))

		let newHeaderLayer = CAShapeLayer()
		newHeaderLayer.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
		newHeaderLayer.path = cutDirection.cgPath

		cellView.layer.mask = newHeaderLayer

		contentView.addSubview(cellView)
		cellView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)


		cellView.addSubview(headerImageView)

		headerImageView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
		
		headerImageView.frame = CGRect(x: 0, y: 0, width: frameWidth, height: 350)
		headerImageView.layer.mask = newHeaderLayer

	}

	private func setupViewCell()  {
		setupUIElement()

		headerImageView.addSubview(profileImage)
		headerImageView.addSubview(userEmail)
		headerImageView.addSubview(userFullName)

		profileImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 120, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
		userFullName.anchor(top: profileImage.topAnchor, left: profileImage.rightAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
		userEmail.anchor(top: userFullName.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 30, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViewCell()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
