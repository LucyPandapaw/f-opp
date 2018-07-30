//
//  CatImagesViewController.swift
//  Assignment5
//
//  Created by Charles Augustine on 7/15/18.
//


import UIKit
import CoreData

class CatImagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
	// MARK: UICollectionViewDataSource
    var resultsController: NSFetchedResultsController<Image>!
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return resultsController?.sections?[section].numberOfObjects ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatImageCell", for: indexPath) as! CatImageCell
        let image = resultsController.object(at: indexPath)
        cell.update(forImageName: image)

		return cell
	}
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
    
	// MARK: View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        resultsController = CatService.shared.images(for: categoryIndex)
        resultsController.delegate = self
	}

	// MARK: Properties
	var categoryIndex: Category! = nil

	// MARK: Properties (IBOutlet)
	@IBOutlet private weak var collectionView: UICollectionView!
}
