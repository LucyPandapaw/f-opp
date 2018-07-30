//
//  CatImagesViewController.swift
//  Assignment4
//
//  Created by Fangjian Shang on 7/18/18.
//

import UIKit

class CatImagesViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var categoryIndex: Int!

	@IBOutlet private weak var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return count number
        return CatService.shared.imageNamesForCategory(atIndex: categoryIndex).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //refer images by names with index
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! NewCell
        let imageName = CatService.shared.imageNamesForCategory(atIndex: categoryIndex)
        cell.catImageView.image = UIImage(named: imageName[indexPath.row])
        return cell
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		view.layoutIfNeeded()
		let size = (view.frame.width / 2) - 5
		(collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize(width: size, height: size)
	}
}
