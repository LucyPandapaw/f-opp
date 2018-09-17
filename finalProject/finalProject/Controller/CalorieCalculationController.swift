//
//  CalorieCalculationController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/14/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import UserNotifications

class CalorieCalculationController: UITableViewController, MFMailComposeViewControllerDelegate{
    
    
    //info about weight calculation formulas and app
    required init!(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    var mealsCalorie: Double = 0
    var workoutsCalorie: Double = 0
    var calorieLeft: Double = 0
    
    @IBOutlet weak var calculationButton: UIButton!
    
    @IBOutlet weak var calorieLeftLabel: UILabel!
    
    @IBOutlet private weak var reminderSwitch: UISwitch!

    @IBOutlet weak var reminderNotificationSwitch: UISwitch!
    
    @IBOutlet weak var emailButton: UIButton!
//    UserService.shared.setCalorieLeft(cal: Double)
//    UserService.shared.getCalorieLeft
    @IBAction func CalculateForToday(_ sender: Any) {
        
        if let weightString = UserService.shared.getSameWeightCalorie, let weight = Double(weightString) {
            UserService.shared.setCalorieLeft(cal: weight)
            calorieLeft = weight
            
            countFood()
            countExercise()
            
            //calorie maintaining + meals - workouts
            calorieLeft = weight + mealsCalorie - workoutsCalorie
            UserService.shared.setCalorieLeft(cal: calorieLeft)
        }
        else {
            calorieLeft = 0
        }        
        calorieLeftLabel.text = "\(UserService.shared.getCalorieLeft) cals"
        print(UserService.shared.getCalorieLeft)
        if UserService.shared.getCalorieLeft <= 0 {
            let alertController = UIAlertController(title: "Congradulations!", message: "You had reached today's diet goal :D", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Awesome", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        calorieLeftLabel.text = "\(UserService.shared.getCalorieLeft) cals"
	}

    
    //how to call existing cells in listviewcontroller?? then double(FoodType.calorieperserving)* Meal.amount
    //Food cell, typeString, amountString, MealDetailController, meals()
    //first fetch data, (meals) = (first item)calorie* serving + (second item)calorie* serving + (third item)calorie* serving + ...
    func countFood(){
        mealsCalorie = 0
        let meals = DietService.shared.meals()
        for ameal in meals{
            let singlem = ameal.amount * Double((ameal.foodType?.calorieperserving)!)
            mealsCalorie += singlem
        }
    }
    //how to call existing cells in listviewcontroller?? then double(Exercise.caloriesPerHour)* Workout.amount
    //Exercise cell, exerciseString, numberOfDurationString, WorkoutDetailController, workouts()
    //first fetch data, (workout) = (first type)calorie* hour + (second type)calorie* hour + (third type)calorie* hour + ...
    func countExercise(){
        workoutsCalorie = 0
        let workouts = DietService.shared.workouts()
        for aworkout in workouts{
            let singlew = aworkout.duration * Double((aworkout.exercise?.caloriesPerHour)!)
            workoutsCalorie += singlew
        }
    }    
    
    //////////////////////////////begin notification
    func dietSummaryNotification(){
		deleteDietSummaryNotification()

        let notification = UNMutableNotificationContent()
        notification.title = "Daily Diet Goal"
        notification.body = "You have \(calorieLeft) calories left for today"
        notification.sound = UNNotificationSound.default()

		let now = Date()
		var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: now)
        dateComponents.hour = 22
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let triggerRequest = UNNotificationRequest(identifier: "ReminderNotification", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(triggerRequest, withCompletionHandler: nil)

        UserService.shared.saveSwitch(switchCheck: reminderSwitch.isOn)
		// TODO: Save that the switch is on in the user defaults
    }

	func deleteDietSummaryNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
		UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        UserService.shared.saveSwitch(switchCheck: reminderSwitch.isOn)
		// TODO: Save that the switch is off in the user defaults
	}
    
    //not understand this 
    @IBAction private func reminderSwitchToggled(_ sender: Any) {
        //unexpected nil here
		guard reminderSwitch.isOn else {
			deleteDietSummaryNotification()
            return
		}

        checkNotificationAuthorizationStatus { (authorized) in
			if authorized {
				self.dietSummaryNotification()
			}
			else {
				self.reminderSwitch.setOn(false, animated: true)
				self.deleteDietSummaryNotification()
			}
        }
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        reminderSwitch.setOn(UserService.shared.getSwitch, animated: true)
		// TODO: Look at user defaults to see if the reminder switch should be on or off
	}
    
    
    //What does this do???
    private func checkNotificationAuthorizationStatus(_ notificationOperation: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            let authorized = settings.authorizationStatus == .authorized

            // This callback happens off the main queue, so dispatch the notification operation back to the main queue
            DispatchQueue.main.async {
                if !authorized {
                    let alertController = UIAlertController(title: "Notifications Are Not Allowed", message: "Check your privacy settings and enable notifications", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }

                notificationOperation(authorized)
            }
        }
    }
    //////////////////////////////end notification
    
    
    //////////////////////////////begin email
    @IBAction func emailService(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = self
            email.setToRecipients(["\(UserService.shared.getUserEmail!)"])
            email.setSubject("Diet Summary")
            email.setMessageBody("You have \(calorieLeft) calories left for today", isHTML: false)
            present(email, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Sending Email Failed", message: "Your device is not configured to send emails", preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
			present(alertController, animated: true, completion: nil)
        }
    }

	//Delegate
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		dismiss(animated: true, completion: nil)
	}
    //////////////////////////////end email
}
