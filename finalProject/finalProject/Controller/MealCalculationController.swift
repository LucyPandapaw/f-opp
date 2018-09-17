//
//  MealCalculationController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/10/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit

class MealCalculationController: UITableViewController{
    @IBOutlet weak var meatText: UITextField!
    
    @IBOutlet weak var vegiText: UITextField!
    
    @IBOutlet weak var drinkText: UITextField!
    
    @IBOutlet weak var dessertText: UITextField!
    
    @IBOutlet weak var snacksText: UITextField!
    
    @IBOutlet weak var calorieLeftText: UITextField!
        
    @IBOutlet weak var saveResultButton: UIButton!
    
    @IBAction func saveResult(_ sender: Any) {
        //save into coredata
    }
    
    @IBOutlet weak var calculateLeftButton: UIButton!
    
    @IBAction func calculateLeftCalorie(_ sender: Any) {
        //dayNeedCalorie - exerciseCalorie + mealCalorie
    }
    
    
    
    
    //pickers to store and extract values
    
    
    
    
    
    
    //switch meal cases to calculate calories
    
    /////////////////////////begin picker
    
    /////////////////////////end picker
    
    
    ///////////////////////////begin email service
    @IBOutlet weak var emailButton: UIButton!
    
    @IBAction func emailReport(_ sender: Any) {
        
        
    }
    
    
    
    
    /////////////////////////////end email service
}
