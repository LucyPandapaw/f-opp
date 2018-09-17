//
//  WorkoutDetailController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/14/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit

class WorkoutDetailController: UITableViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet private weak var exerciseTypeTextField: UITextField!
	@IBOutlet private weak var numberOfDurationTextField: UITextField!

	var exercise: Exercise?
    var numberOfDurationString: String?
    
    let numberOfDuration = ["0.5","1.0","1.5","2.0","2.5","3.0","3.5","4.0","4.5","5.0","5.5","6.0","6.5","7.0","7.5","8.0",
                            "8.5","9.0","9.5","10.0"]

	let exercisesCollection = DietService.shared.exercises()

    var currentTextfield: UITextField?
    var currentPickerview = UIPickerView()

	var workout: Workout? {
		didSet {
			exercise = workout?.exercise
			if let duration = workout?.duration {
				numberOfDurationString = "\(duration)"
			}
			else {
				numberOfDurationString = ""
			}
		}
	}
    
    @IBAction private func cancel(_ sender: Any) {
        performSegue(withIdentifier: "exerciseDetailDidFinishUnwindSegue", sender: self)
    }
    
    @IBAction private func save(_ sender: Any) {
		guard let exercise = self.exercise, let durationString = numberOfDurationString, let duration = Double(durationString) else {
			return
		}

		do {
            try DietService.shared.addWorkout(withExercise: exercise, andDuration: duration)
            performSegue(withIdentifier: "exerciseDetailDidFinishUnwindSegue", sender: self)
        }
        catch _ {
            let alertController = UIAlertController(title: "Save Failed", message: "Exercise not saved", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Go back", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

	@IBAction private func update(_ sender: Any) {
		guard let workout = self.workout, let exercise = self.exercise, let durationString = numberOfDurationString, let duration = Double(durationString) else {
			return
		}

		do {
			try DietService.shared.editWorkout(workout, withNewExercise: exercise, andDuration: duration)
		}
		catch _ {
			let alertController = UIAlertController(title: "Save failed", message: "Failed to update the workout", preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			present(alertController, animated: true, completion: nil)
		}
	}
    
    //tableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
        	exerciseTypeTextField.becomeFirstResponder()
		}
		else {
        	numberOfDurationTextField.becomeFirstResponder()
		}
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if workout != nil {
			navigationItem.title = "Edit Workout"
			navigationItem.leftBarButtonItem = nil
			navigationItem.rightBarButtonItem = nil
//			navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(WorkoutDetailController.update(_:)))
		}
		else {
			navigationItem.title = "Add Workout"
			navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(WorkoutDetailController.cancel(_:)))
			navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(WorkoutDetailController.save(_:)))
		}

		exerciseTypeTextField.text = exercise?.name
		numberOfDurationTextField.text = numberOfDurationString
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneToolBar = UIToolbar()
        doneToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UserStatusController.dismissKeyBoard))
        doneToolBar.setItems([doneButton], animated: false)
        doneToolBar.isUserInteractionEnabled = true
        
        currentPickerview.delegate = self
        currentPickerview.dataSource = self
        
        exerciseTypeTextField.inputView = currentPickerview
        numberOfDurationTextField.inputView = currentPickerview
        
        exerciseTypeTextField.inputAccessoryView = doneToolBar
        numberOfDurationTextField.inputAccessoryView = doneToolBar
        
    }
    
    ///////////////////////////////begin picker
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		
        if currentTextfield == exerciseTypeTextField{
            return exercisesCollection.count
        }else if currentTextfield == numberOfDurationTextField{
            return numberOfDuration.count
        }else{
            return 0
        }
    }

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
        if currentTextfield == exerciseTypeTextField{
            return exercisesCollection[row].name
        }else if currentTextfield == numberOfDurationTextField{
            return numberOfDuration[row]
        }else{
            return ""
        }
    }

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if currentTextfield == exerciseTypeTextField{
			exercise = exercisesCollection[row]
			exerciseTypeTextField.text = exercise?.name
		}else if currentTextfield == numberOfDurationTextField{
			numberOfDurationString = numberOfDuration[row]
			numberOfDurationTextField.text = numberOfDurationString
		}

		update(self)
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		currentTextfield = textField
		currentPickerview.reloadAllComponents()

		let selectedRow: Int
		if currentTextfield == exerciseTypeTextField, let exercise = self.exercise, let index = exercisesCollection.index(of: exercise) {
			selectedRow = index
		}
		else if currentTextfield == numberOfDurationTextField, let durationString = self.numberOfDurationString, let index = numberOfDuration.index(of: durationString) {
			selectedRow = index
		}
		else {
			selectedRow = 0
		}
		currentPickerview.selectRow(selectedRow, inComponent: 0, animated: false)

		return true
	}
}
