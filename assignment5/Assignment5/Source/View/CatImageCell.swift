//
//  CatImageCell.swift
//  Assignment5
//
//  Created by Charles Augustine on 7/15/18.
//


import UIKit


class CatImageCell: UICollectionViewCell {
	// MARK: Configuration
	func update(forImageName imageName: Image) {
		catImageView.image = UIImage(named: imageName.imagename!)
	}

	// MARK: Properties (IBOutlet)
	@IBOutlet private weak var catImageView: UIImageView!
}
