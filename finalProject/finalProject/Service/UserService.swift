//
//  UserService.swift
//  finalProject
//
//  Created by Charles Augustine on 8/22/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation


class UserService {
	private let userDefaults: UserDefaults

	//Static Constant
	static let shared = UserService()

	//Initialization
	private init() {
		userDefaults = UserDefaults.standard
	}
    //switch
    func saveSwitch(switchCheck: Bool){
        userDefaults.set(switchCheck, forKey: "switchcheck")
    }
    var getSwitch: Bool{
        get{
            return userDefaults.bool(forKey: "switchcheck")
        }
    }
    
	//remove data
	func cleanWeightLoss(){
		userDefaults.removeObject(forKey: "userweightloss")
		userDefaults.removeObject(forKey: "useridealweight")
		userDefaults.removeObject(forKey: "usersameweightcalorie")
		userDefaults.removeObject(forKey: "userplan")
        userDefaults.removeObject(forKey: "userLeft")
	}
    
    func cleanUserStatus(){
        userDefaults.removeObject(forKey: "userheight")
        userDefaults.removeObject(forKey: "userage")
        userDefaults.removeObject(forKey: "usersex")
        userDefaults.removeObject(forKey: "userweight")
        userDefaults.removeObject(forKey: "useremail")
    }
    
	func addUserStatus(height: String, age: String, sex: String, weight: String, email: String){
        userDefaults.set(height, forKey: "userheight")
        userDefaults.set(age, forKey: "userage")
        userDefaults.set(sex, forKey: "usersex")
        userDefaults.set(weight, forKey: "userweight")
        userDefaults.set(email, forKey: "useremail")
    }

	var getUserHeight: String? {
		get {
			return userDefaults.object(forKey: "userheight") as? String
		}
	}
    var getUserAge: String? {
        get {
            return userDefaults.object(forKey: "userage") as? String
        }
    }
    var getUserSex: String? {
        get {
            return userDefaults.object(forKey: "usersex") as? String
        }
    }
    var getUserWeight: String? {
        get {
            return userDefaults.object(forKey: "userweight") as? String
        }
    }
    var getUserEmail: String? {
        get {
            return userDefaults.object(forKey: "useremail") as? String
        }
    }
    var getWeightLossWeekly: String? {
        get {
            return userDefaults.object(forKey: "userweightloss") as? String
        }
    }
    var getIdealWeight: String? {
        get {
            return userDefaults.object(forKey: "useridealweight") as? String
        }
    }
    var getSameWeightCalorie: String? {
        get {
            return userDefaults.object(forKey: "usersameweightcalorie") as? String
        }
    }
    var getPlan: String? {
        get {
            return userDefaults.object(forKey: "userplan") as? String
        }
    }
    var getCalorieLeft: Double{
        get{
            return userDefaults.double(forKey: "userLeft")
        }
    }
    
    
//    func addDailyCalorie(weightLossWeekly:String, idealWeight: String, sameWeightCalorie: String, plan: String){
//        userDefaults.set(weightLossWeekly, forKey: "userweightloss")
//        userDefaults.set(idealWeight, forKey: "useridealweight")
//        userDefaults.set(sameWeightCalorie, forKey: "usersameweightcalorie")
//        userDefaults.set(plan, forKey: "userplan")
//    }
    
    func setWeightLossWeekly(weightLossWeekly:String){
        userDefaults.set(weightLossWeekly, forKey: "userweightloss")
    }
    func setIdealWeight(idealWeight: String){
        userDefaults.set(idealWeight, forKey: "useridealweight")
    }
    func setSameWeightCalorie(sameWeightCalorie: String){
        userDefaults.set(sameWeightCalorie, forKey: "usersameweightcalorie")
    }
    func setPlan(plan: String){
        userDefaults.set(plan, forKey: "userplan")
    }
    func setCalorieLeft(cal: Double){
        userDefaults.set(cal, forKey: "userLeft")
    }
}
