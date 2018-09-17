//
//  MealDetailController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/14/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit

class MealDetailController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    
    @IBOutlet private weak var foodTypeTextField: UITextField!
    //var typeString: String?
    @IBOutlet private weak var amountTextField: UITextField!
    //var amountString: String?
    
    let numberOfServing = ["0.5","1.0","1.5","2.0","2.5","3.0","3.5","4.0","4.5","5.0","5.5","6.0","6.5","7.0","7.5","8.0",
                           "8.5","9.0","9.5","10.0"]
    
    let foodNamesCollection = DietService.shared.foodTypes()
    //var foodNames: [String] = []
    
    var currentTextfield: UITextField?
    var currentPickerview = UIPickerView()
    
    //if return dictionary, parse into array of string
    var foodtype: FoodType?
    //var amount: Double?
    
    //var meal: Meal?
    var numberOfAmountString: String?
//    func getFoodNames(){
//        for items in foodNamesCollection{
//            foodNames.append(items.name!)
//        }
//    }
    var meal: Meal?{
        didSet {
            foodtype = meal?.foodType
            if let amount = meal?.amount{
                numberOfAmountString = "\(amount)"
            }else{
                numberOfAmountString = ""
            }
        }
    }
    
    
    @IBAction private func cancel(_ sender: Any) {
        performSegue(withIdentifier: "foodDetailDidFinishUnwindSegue", sender: self)
    }
    
    @IBAction private func save(_ sender: Any) {
		guard let foodtype = self.foodtype, let amountString = numberOfAmountString, let amount = Double(amountString) else {
			return
		}

        do {
            try DietService.shared.addMeal(withFoodType: foodtype, andAmount: amount)
            performSegue(withIdentifier: "foodDetailDidFinishUnwindSegue", sender: self)
        }
        catch _ {
            let alertController = UIAlertController(title: "Save Failed", message: "Food not saved", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Go back", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction private func update(_ sender: Any) {
        guard let meal = self.meal, let foodtype = self.foodtype, let amountString = numberOfAmountString, let amount = Double(amountString) else {
            return
        }
        
        do {
            try DietService.shared.editMeal(meal, withNewFoodType: foodtype, andAmount: amount)
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
        	foodTypeTextField.becomeFirstResponder()
		}
		else {
        	amountTextField.becomeFirstResponder()
		}
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if meal != nil {
			navigationItem.title = "Edit Meal"
			navigationItem.leftBarButtonItem = nil
			navigationItem.rightBarButtonItem = nil
		}
		else {
			navigationItem.title = "Add Meal"
			navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MealDetailController.cancel(_:)))
			navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(MealDetailController.save(_:)))
		}
        foodTypeTextField.text = foodtype?.name
        amountTextField.text = numberOfAmountString
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getFoodNames()
        let doneToolBar = UIToolbar()
        doneToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UserStatusController.dismissKeyBoard))
        doneToolBar.setItems([doneButton], animated: false)
        doneToolBar.isUserInteractionEnabled = true
        
        currentPickerview.delegate = self
        currentPickerview.dataSource = self
        
        foodTypeTextField.inputView = currentPickerview
        amountTextField.inputView = currentPickerview
        
        foodTypeTextField.inputAccessoryView = doneToolBar
        amountTextField.inputAccessoryView = doneToolBar
        
    }
    
    ///////////////////////////////begin picker
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		
        if currentTextfield == foodTypeTextField{
            return foodNamesCollection.count
        }else if currentTextfield == amountTextField{
            return numberOfServing.count
        }else{
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
        if currentTextfield == foodTypeTextField{
            return foodNamesCollection[row].name
        }else if currentTextfield == amountTextField{
            return numberOfServing[row]
        }else{
            return ""
        }
    }
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if currentTextfield == foodTypeTextField{
			foodtype = foodNamesCollection[row]
			foodTypeTextField.text = foodtype?.name
		}else if currentTextfield == amountTextField{
			numberOfAmountString = numberOfServing[row]
			amountTextField.text = numberOfAmountString
		}
        update(self)
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		currentTextfield = textField
		currentPickerview.reloadAllComponents()
        
        let selectedRow: Int
        if currentTextfield == foodTypeTextField, let foodtype = self.foodtype, let index = foodNamesCollection.index(of: foodtype) {
            selectedRow = index
        }
        else if currentTextfield == amountTextField, let amountString = self.numberOfAmountString, let index = numberOfServing.index(of: amountString) {
            selectedRow = index
        }
        else {
            selectedRow = 0
        }
        currentPickerview.selectRow(selectedRow, inComponent: 0, animated: false)


		return true
	}
}
