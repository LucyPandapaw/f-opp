//
//  CategoryListViewController.swift
//  Assignment4
//
//  Created by Fangjian Shang on 7/18/18.
//

import UIKit

class CategoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    @IBOutlet private weak var categoryList: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return count number
        return CatService.shared.catCategories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //extracting titles and subtitles
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let tableCellValue = CatService.shared.catCategories()[indexPath.row]
        tableCell.textLabel?.text = tableCellValue.title
        tableCell.detailTextLabel?.text = tableCellValue.subtitle
        return tableCell
    }
    //Search bar with cancel button
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
 //       searchBar.setShowsCancelButton(true, animated: true)
 //   }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //    searchBar.text = nil
    //    searchBar.setShowsCancelButton(false, animated: true)
        // Remove focus from the search bar.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageViewSegue" {
            let catImagesViewController = segue.destination as! CatImagesViewController
            let indexPath = categoryList.indexPathForSelectedRow!
            //select row to transition
            catImagesViewController.categoryIndex = indexPath.row
            //catImagesViewController.delegate = self
            categoryList.deselectRow(at: indexPath, animated: true)
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
		willShowNotification = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
			self?.adjustSafeArea(forWillShowKeyboardNotification: notification)
		}
		willHideNotification = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
			self?.adjustSafeArea(forWillHideKeyboardNotification: notification)
		}
	}

	deinit {
		if let notification = willShowNotification {
			NotificationCenter.default.removeObserver(notification)
		}

		if let notification = willHideNotification {
			NotificationCenter.default.removeObserver(notification)
		}
	}

	private var willShowNotification: Any?
	private var willHideNotification: Any?
}
