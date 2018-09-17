//
//  WorkoutListController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/14/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WorkoutListController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    private var fetchedResultsController: NSFetchedResultsController<Workout>?
    
    @IBOutlet weak private var ExerciseList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController = DietService.shared.workoutsResultsController()
        fetchedResultsController?.delegate = self
    }
    
    @IBAction private func exerciseDetailDidFinish(_ sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    
    //DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseListCell", for: indexPath)
        let workout = fetchedResultsController!.object(at: indexPath)
        
        //what to show for subtitle
		cell.textLabel?.text = workout.exercise?.name
		cell.detailTextLabel?.text = "\(workout.duration) hours"

        return cell
    }

    internal func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        ExerciseList.reloadData()
    }
    
    //deselect row
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = ExerciseList.indexPathForSelectedRow {
            ExerciseList.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWorkoutSegue" {
			// Nothing to do
        }
        else if segue.identifier == "WorkoutDetailSegue" {
            if let indexPath = ExerciseList.indexPathForSelectedRow, let selectedWorkout = fetchedResultsController?.object(at: indexPath) {
                let exerciseDetailController = segue.destination as! WorkoutDetailController
                exerciseDetailController.workout = selectedWorkout
            }
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
}
