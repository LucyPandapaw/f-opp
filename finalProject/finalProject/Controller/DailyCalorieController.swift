//
//  DailyCalorieController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/10/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import Foundation
import UIKit

class DailyCalorieController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    //let userDefaults = UserDefaults.standard
    //let userDefaults = UserService.shared
    
    //@IBOutlet weak var idealWeightLabel: UITextField!
    //
    
    //@IBOutlet weak var maintainWeightLabel: UITextField!
    
    
    @IBOutlet weak var idealWeightLabel: UILabel!
    var idealWeightString: String = ""
    
    @IBOutlet weak var maintainWeightLabel: UILabel!
    var sameWeightCalorieString: String = ""
    
    @IBOutlet weak var weightLossWeeklyText: UITextField!
    var weightLossString: String = ""
    
    @IBOutlet weak var planButton: UIButton!
    @IBOutlet weak var planLabel: UILabel!
    var planString: String = ""
    
    @IBAction func generatePlan(_ sender: Any) {
        let weightLossWeeklyString = weightLossWeeklyText.text
        if weightLossWeeklyString?.isEmpty == true {
            let alertController = UIAlertController(title: "Plan Failure", message: "Please select the weight you wanna lose", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
			return
        }else{
            //first fetch data, if XX lbs, (calorie) = sameWeightCalorie - XX* 500
            //(day) = (user.weight - idealWeight)/XX * 7
            //userDefaults.set(weightLossWeeklyText.text, forKey: "userweightloss")
            UserService.shared.setWeightLossWeekly(weightLossWeekly: weightLossWeeklyString!)
            idealWeightVarSt = idealWeight()
            //slicing index of "-" + 1 to the end to get max ideal weight
            guard let dashIndex = idealWeightVarSt.index(of: "-") else {
                let alertController = UIAlertController(title: "Plan Failure", message: "Please check the height you selected in user attributes", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
                return
            }
            let lastNumberIndex = idealWeightVarSt.index(dashIndex, offsetBy: 1)
            let weightString = String(idealWeightVarSt[lastNumberIndex...])

            idealWeightVarNum = Int(weightString)!

            print(idealWeightVarNum)
            idealWeightLabel.text = idealWeightVarSt
            //userDefaults.set(idealWeightLabel.text, forKey: "useridealweight")
            UserService.shared.setIdealWeight(idealWeight: idealWeightVarSt)
        
            sameWeightCalorieVar = sameWeightCalorie()
            sameWeightCalorieString = String(sameWeightCalorieVar)
            maintainWeightLabel.text = sameWeightCalorieString
            //userDefaults.set(maintainWeightLabel.text, forKey: "usersameweightcalorie")
            UserService.shared.setSameWeightCalorie(sameWeightCalorie: sameWeightCalorieString)
        
            //calculate plan
            dailyCalorieConsumptionGoal()
        
            if extraWeight > 0{
                let planString = "You need to consume \(dailyCalorie) calories per day for \(daysOfPlan) day\(daysOfPlan == 1 ? "" : "s")"
                planLabel.text = planString
                //userDefaults.set(planLabel.text, forKey: "userplan")
                UserService.shared.setPlan(plan: planString)
            }else{
                let planString = "You do not need to loss weight"
                planLabel.text = planString
                UserService.shared.setPlan(plan: planString)
            }
        }
    }
    
    let weightLossInLbs = ["0.5","1.0","1.5","2.0"]
    var idealWeightVarSt = ""
    var idealWeightVarNum: Int = 0
    var sameWeightCalorieVar: Double = 0
    var dailyCalorie: Double = 0
    var daysOfPlan: Int = 0
    var extraWeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightLossPicker()
        doneToolBar()
        let weightLossWeeklyString = UserService.shared.getWeightLossWeekly ?? ""
        weightLossWeeklyText.text = weightLossWeeklyString
        weightLossString = weightLossWeeklyString
        
        idealWeightLabel.text = UserService.shared.getIdealWeight
        
        maintainWeightLabel.text = UserService.shared.getSameWeightCalorie
        
        
        //Why breakpoint is hit but nothing get showed???
        planLabel.text = UserService.shared.getPlan
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let weightLossWeeklyString = UserService.shared.getWeightLossWeekly ?? ""
        weightLossWeeklyText.text = weightLossWeeklyString
        
        idealWeightLabel.text = UserService.shared.getIdealWeight
        
        maintainWeightLabel.text = UserService.shared.getSameWeightCalorie
        
        //Why breakpoint is hit but nothing get showed???
        planLabel.text = UserService.shared.getPlan
    }
    ///////////////////////////////begin picker
    func weightLossPicker(){
        let weightLossPicker = UIPickerView()
        weightLossPicker.delegate = self
        weightLossWeeklyText.inputView = weightLossPicker
    }
    
    func doneToolBar(){
        let doneToolBar = UIToolbar()
        doneToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UserStatusController.dismissKeyBoard))
        doneToolBar.setItems([doneButton], animated: false)
        doneToolBar.isUserInteractionEnabled = true
        weightLossWeeklyText.inputAccessoryView = doneToolBar
    }
    
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightLossInLbs.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weightLossInLbs[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightLossString = weightLossInLbs[row]
        weightLossWeeklyText.text = weightLossString        
    }
    //////////////////////////////////end picker
    //How to put calculated result into coredata???
    func idealWeight() -> String {
        var idealWeight = ""
        //how to access saved value from another controller?
        //save into singleton via userdefaults
        if UserService.shared.getUserHeight == "148" || UserService.shared.getUserHeight == "149"{
            idealWeight = "44-55"
        }else if UserService.shared.getUserHeight == "150" || UserService.shared.getUserHeight == "151"{
            idealWeight = "45-56"
        }else if UserService.shared.getUserHeight == "152" || UserService.shared.getUserHeight == "153"{
            idealWeight = "46-58"
        }else if UserService.shared.getUserHeight == "154" || UserService.shared.getUserHeight == "155"{
            idealWeight = "47-59"
        }else if UserService.shared.getUserHeight == "156" || UserService.shared.getUserHeight == "157"{
            idealWeight = "49-61"
        }else if UserService.shared.getUserHeight == "158" || UserService.shared.getUserHeight == "159"{
            idealWeight = "50-62"
        }else if UserService.shared.getUserHeight == "160" || UserService.shared.getUserHeight == "161"{
            idealWeight = "51-64"
        }else if UserService.shared.getUserHeight == "162" || UserService.shared.getUserHeight == "163"{
            idealWeight = "52-66"
        }else if UserService.shared.getUserHeight == "164" || UserService.shared.getUserHeight == "165"{
            idealWeight = "54-67"
        }else if UserService.shared.getUserHeight == "166" || UserService.shared.getUserHeight == "167"{
            idealWeight = "55-69"
        }else if UserService.shared.getUserHeight == "168" || UserService.shared.getUserHeight == "169"{
            idealWeight = "56-71"
        }else if UserService.shared.getUserHeight == "170" || UserService.shared.getUserHeight == "171"{
            idealWeight = "58-72"
        }else if UserService.shared.getUserHeight == "172" || UserService.shared.getUserHeight == "173"{
            idealWeight = "59-74"
        }else if UserService.shared.getUserHeight == "174" || UserService.shared.getUserHeight == "175"{
            idealWeight = "61-76"
        }else if UserService.shared.getUserHeight == "176" || UserService.shared.getUserHeight == "177"{
            idealWeight = "62-77"
        }else if UserService.shared.getUserHeight == "178" || UserService.shared.getUserHeight == "179"{
            idealWeight = "63-79"
        }else if UserService.shared.getUserHeight == "180" || UserService.shared.getUserHeight == "181"{
            idealWeight = "65-81"
        }else if UserService.shared.getUserHeight == "182" || UserService.shared.getUserHeight == "183"{
            idealWeight = "66-83"
        }else if UserService.shared.getUserHeight == "184" || UserService.shared.getUserHeight == "185"{
            idealWeight = "68-85"
        }else if UserService.shared.getUserHeight == "186" || UserService.shared.getUserHeight == "187"{
            idealWeight = "69-86"
        }else if UserService.shared.getUserHeight == "188" || UserService.shared.getUserHeight == "189"{
            idealWeight = "71-88"
        }else if UserService.shared.getUserHeight == "190" || UserService.shared.getUserHeight == "191"{
            idealWeight = "72-90"
        }else if UserService.shared.getUserHeight == "192" || UserService.shared.getUserHeight == "193"{
            idealWeight = "74-92"
        }else if UserService.shared.getUserHeight == "194" || UserService.shared.getUserHeight == "195"{
            idealWeight = "75-94"
        }else if UserService.shared.getUserHeight == "196" || UserService.shared.getUserHeight == "197"{
            idealWeight = "77-96"
        }else if UserService.shared.getUserHeight == "198" || UserService.shared.getUserHeight == "199"{
            idealWeight = "79-98"
        }else if UserService.shared.getUserHeight == "200" || UserService.shared.getUserHeight == "201"{
            idealWeight = "80-100"
        }else if UserService.shared.getUserHeight == "202" || UserService.shared.getUserHeight == "203"{
            idealWeight = "82-102"
        }else if UserService.shared.getUserHeight == "204" || UserService.shared.getUserHeight == "205"{
            idealWeight = "83-104"
        }
        return idealWeight
    }
    
    func sameWeightCalorie() -> Double{
        //men: 10* weight(kg) + 6.25* height(cm) - 5* age(y) + 5
        //women: 10* weight(kg) + 6.25* height(cm) - 5* age(y) - 161
        var sameWeightCalorie: Double
        //or 3 guard?
        //too complex to unwrap string into double! 6.25
        if UserService.shared.getUserSex == "Male"{
            sameWeightCalorie = Double(UserService.shared.getUserWeight!)!*10 +
                Double(UserService.shared.getUserHeight!)!*6.25 -
                Double(UserService.shared.getUserAge!)!*5 + 5
        }else{
            sameWeightCalorie = Double(UserService.shared.getUserWeight!)!*10 +
                Double(UserService.shared.getUserHeight!)!*6.25 -
                Double(UserService.shared.getUserAge!)!*5 - 161
        }
        return sameWeightCalorie
    }
    
    func dailyCalorieConsumptionGoal(){
        //first fetch data, if XX lbs, (calorie) = sameWeightCalorie - XX* 500
        //(day) = (user.weight - idealWeight)/XX * 7
        extraWeight = Int(UserService.shared.getUserWeight!)! - idealWeightVarNum
        guard extraWeight > 0 else{
            
            let alertController = UIAlertController(title: "Diet goal suggestion", message: "Your weight is already considered healthy, suggesting maintain weight instead of losing weight", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Awesome!", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return
        }
        if weightLossString == "0.5"{
            dailyCalorie = sameWeightCalorieVar - 0.5*500
            let doubleDay = Double(extraWeight)/0.5*7
            daysOfPlan = Int(ceil(doubleDay))
        }else if weightLossString == "1.0"{
            dailyCalorie = sameWeightCalorieVar - 1.0*500
            let doubleDay = Double(extraWeight)/1.0*7
            daysOfPlan = Int(ceil(doubleDay))
        }else if weightLossString == "1.5"{
            dailyCalorie = sameWeightCalorieVar - 1.5*500
            let doubleDay = Double(extraWeight)/1.5*7
            daysOfPlan = Int(ceil(doubleDay))
        }else if weightLossString == "2.0"{
            dailyCalorie = sameWeightCalorieVar - 2.0*500
            let doubleDay = Double(extraWeight)/2.0*7
            daysOfPlan = Int(ceil(doubleDay))
        }
    }
    
    //how to expend static cell if text is too long
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        //planLabel.text = "You need to consume 0 calories per day for 0 days"
//    }
}
