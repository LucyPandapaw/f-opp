//
//  MealListController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/14/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MealListController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    private var fetchedResultsController: NSFetchedResultsController<Meal>?
    
    @IBOutlet weak private var MealList: UITableView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController = DietService.shared.mealsResultsController()
        fetchedResultsController?.delegate = self
    }
    
    @IBAction private func foodDetailDidFinish(_ sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    
    //Delegate
//    func mealDetailDelegate(_ mealDetailController: MealDetailController) -> Int {
//        return MealList.numberOfRows(inSection: 0)
//    }
    //DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealListCell", for: indexPath)
        let meal = fetchedResultsController!.object(at: indexPath)
                
        cell.textLabel?.text = meal.foodType?.name
        cell.detailTextLabel?.text = "\(meal.amount) servings"

        return cell
    }
    internal func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        MealList.reloadData()
    }
    
    //deselect row
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = MealList.indexPathForSelectedRow {
            MealList.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFoodSegue" {
//            let MealDetailController = segue.destination as! MealDetailController
//            let IndexPath = MealList.indexPathForSelectedRow!
//            add cell
//            MealList.deselectRow(at: IndexPath, animated: true)
//            let navigationController = segue.destination as! UINavigationController
//            let mealDetailController = navigationController.topViewController as! MealDetailController
        }
        else if segue.identifier == "FoodDetailSegue" {
            if let indexPath = MealList.indexPathForSelectedRow, let selectedMeal = fetchedResultsController?.object(at: indexPath) {
                let mealDetailController = segue.destination as! MealDetailController
                mealDetailController.meal = selectedMeal
            }
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    
}
