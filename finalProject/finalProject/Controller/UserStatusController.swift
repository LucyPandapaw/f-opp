//
//  UserStatusController.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/10/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class UserStatusController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

//    static let shared = UserStatusController()
//    
    //let userDefaults = UserService.shared
    
    
    @IBOutlet weak var emailText: UITextField!
    var emailString: String?
    
    @IBOutlet weak var newDietButton: UIButton!
    
    @IBAction func NewDiet(_ sender: Any) {
        //popup to inform if user sure want to start new diet!!! how to------------------------
        let alertController = UIAlertController(title: "Warning", message: "Once a new diet starts, old data will not be retrieved back", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) in
			//remove exercise and meal list controller
			do {
				try DietService.shared.cleanExerciseAndMeal()
			}
			catch _ {
				let alertController = UIAlertController(title: "Start New Diet Failed", message: "Unable to clean data", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
				self.present(alertController, animated: true, completion: nil)
			}

			UserService.shared.cleanUserStatus()
			UserService.shared.cleanWeightLoss()

			self.updateTextFields()
		}))
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var savebutton: UIButton!
    
    @IBAction func saveAndContinue(_ sender: Any) {
        if (heightText.text?.isEmpty == false) && (ageText.text?.isEmpty == false) && (sexText.text?.isEmpty == false) && (weightText.text?.isEmpty == false) && (emailText.text?.isEmpty == false){
            //UserService.shared.set, no member of set
            UserService.shared.addUserStatus(height: heightText.text!, age: ageText.text!, sex: sexText.text!, weight: weightText.text!, email: emailText.text!)
            //popup to inform user that save succeed!!!
            let alertController = UIAlertController(title: "Save Succeeded!", message: "All data are stored successfully", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Great", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }else{
            let alertController = UIAlertController(title: "Input Failure", message: "Please select all user attributes", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return true
    }

    func dismiss(_ sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    
    
    
    
    
    
    
    @IBOutlet weak var heightText: UITextField!
    var heightString: String?
    @IBOutlet weak var ageText: UITextField!
    var ageString: String?
    @IBOutlet weak var sexText: UITextField!
    var sexString: String?
    @IBOutlet weak var weightText: UITextField!
    var weightString: String?
    
	var currentTextfield: UITextField?
    var currentPickerview = UIPickerView()
    
    //the world's tallest living man in 2009, when he measured 246.5 cm (8 ft 1 in) in height
    //the shortest human adult ever documented and verified, measuring 21.51 in (54.64 cm). Height confirmed by Guinness World Records
    let heightsInCm = ["148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205"]
    let ages = ["18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50",
            "51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70"]
    let sexes = ["Male","Female"]
    let weightsInKg = ["56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86",
                       "87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117",
                "118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148",
                "149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179",
                "180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210",
                "211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241",
                "242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271",
                "272","273","274","275","276","277","278","279","280","281","282","283","284","285","286","287","288","289","290","291","292","293","294","295","296","297","298","299","300","301",
                "302","303","304","305","306","307","308","309","310","311","312","313","314","315",
                "316","317","318","319","320","321","322","323","324","325","326","327","328","329","330","331","332","333","334","335","336","337","338","339","340","341","342","343","344","345","346",
                "347","348","349","350","351","352","353","354","355","356","357","358","359","360","361","362","363","364","365","366","367","368","369","370","371","372","373","374","375","376","377",
                "378","379","380","381","382","383","384","385","386","387","388","389","390","391","392","393","394","395","396","397","398","399","400","401","402","403","404","405","406","407","408",
                "409","410","411","422","423","424","425","426","427","428","429","430","431","432","433","434","435","436","437","438","439","440","441","442","443","444","445","446","447","448","449",
                "450","451","452","453","454","455","456","457","458","459","460","461","462","463","464","465","466","467","468","469"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

		let doneToolBar = UIToolbar()
		doneToolBar.sizeToFit()
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UserStatusController.dismissKeyBoard))
		doneToolBar.setItems([doneButton], animated: false)
		doneToolBar.isUserInteractionEnabled = true

		currentPickerview.delegate = self
		currentPickerview.dataSource = self

		heightText.inputView = currentPickerview
		ageText.inputView = currentPickerview
		sexText.inputView = currentPickerview
		weightText.inputView = currentPickerview

		heightText.inputAccessoryView = doneToolBar
		ageText.inputAccessoryView = doneToolBar
		sexText.inputAccessoryView = doneToolBar
		weightText.inputAccessoryView = doneToolBar

		updateTextFields()
	}

	private func updateTextFields() {
		heightString = UserService.shared.getUserHeight
		heightText.text = heightString
		ageString = UserService.shared.getUserAge
		ageText.text = ageString
		sexString = UserService.shared.getUserSex
		sexText.text = sexString
		weightString = UserService.shared.getUserWeight
		weightText.text = weightString
		emailString = UserService.shared.getUserEmail
		emailText.text = emailString
	}
    
//    func heightPicker(){
//        let heightPicker = UIPickerView()
//        heightPicker.delegate = self
//        heightText.inputView = heightPicker
//    }
//    func agePicker(){
//        let agePicker = UIPickerView()
//        agePicker.delegate = self
//        ageText.inputView = agePicker
//    }
//    func sexPicker(){
//        let sexPicker = UIPickerView()
//        sexPicker.delegate = self
//        sexText.inputView = sexPicker
//    }
//    func weightPicker(){
//        let weightPicker = UIPickerView()
//        weightPicker.delegate = self
//        weightText.inputView = weightPicker
//    }
    
    ////////////////////////////////begin picker
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextfield == heightText{
            return heightsInCm.count
        }else if currentTextfield == ageText{
            return ages.count
        }else if currentTextfield == sexText{
            return sexes.count
        }else if currentTextfield == weightText{
            return weightsInKg.count
        }else{
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextfield == heightText{
            return heightsInCm[row]
        }else if currentTextfield == ageText{
            return ages[row]
        }else if currentTextfield == sexText{
            return sexes[row]
        }else if currentTextfield == weightText{
            return weightsInKg[row]
        }else{
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextfield == heightText{
            heightString = heightsInCm[row]
            heightText.text = heightString
        }else if currentTextfield == ageText{
            ageString = ages[row]
            ageText.text = ageString
        }else if currentTextfield == sexText{
            sexString = sexes[row]
            sexText.text = sexString
        }else if currentTextfield == weightText{
            weightString = weightsInKg[row]
            weightText.text = weightString
        }
    }

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		currentTextfield = textField
		currentPickerview.reloadAllComponents()

		return true
	}

	///////////////////////////////////end picker
    
    
    
}
