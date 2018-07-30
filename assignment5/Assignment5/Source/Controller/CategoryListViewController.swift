//
//  CategoryListViewController.swift
//  Assignment5
//
//  Created by Charles Augustine on 7/15/18.
//


import UIKit
import CoreData

class CategoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    // MARK: UITableViewDataSource
    private var categoryFetchedResultsController: NSFetchedResultsController<Category>!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let values = categoryFetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = values.categorytitle
        cell.detailTextLabel?.text = values.subtitle
        //why indexPath???
        return cell
    }
    
    // MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    // MARK: View Management
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CatImagesSegue" {
            let catImagesViewController = segue.destination as! CatImagesViewController
            let indexPath = tableView.indexPathForSelectedRow!
            catImagesViewController.categoryIndex = categoryFetchedResultsController.object(at: indexPath)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryFetchedResultsController = CatService.shared.catCategories()
        categoryFetchedResultsController.delegate = self
        
        let willShowObserverToken = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { [unowned self] in
            self.adjustSafeArea(forWillShowKeyboardNotification: $0)
        }
        let willHideObserverToken = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { [unowned self] in
            self.adjustSafeArea(forWillHideKeyboardNotification: $0)
        }
        observerTokens += [willShowObserverToken, willHideObserverToken]
    }
    
    // MARK: Deinitialization
    deinit {
        for observerToken in observerTokens {
            NotificationCenter.default.removeObserver(observerToken)
        }
    }
    
    // MARK: Properties (Private)
    private var observerTokens = Array<Any>()
    
    // MARK: Properties (IBOutlet)
    @IBOutlet private weak var tableView: UITableView!
}
