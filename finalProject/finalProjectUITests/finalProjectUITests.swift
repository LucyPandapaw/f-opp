//
//  finalProjectUITests.swift
//  finalProjectUITests
//
//  Created by Fangjian Shang on 8/10/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import XCTest

class finalProjectUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func exampleUserBot(){
        let app = XCUIApplication()
        let firstTab = app.tabBars.buttons.element(boundBy: 0)
        firstTab.tap()
        
        //count tableview
        let tables = app.tables
        XCTAssertGreaterThan(tables.count, 0, "Table count is 0")
        
        //        for index in 0..<tables.count {
        //            let table = tables.element(boundBy: index)
        //
        //            // Test each table
        //        }
        let table = tables.element(boundBy: 0)
        XCTAssertTrue(table.exists, "Table one does not exist")
        let cells = table.cells
        XCTAssertGreaterThan(cells.count, 0, "table does not contain more than 0 cells")
        let heightTextField = app.textFields["HeightTextField"]
        heightTextField.tap()
        //        let firstCell = cells.element(boundBy: 0)
        //      firstCell.tap()
        XCTAssertTrue(heightTextField.exists,"height textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "180")
        
        let ageTextField = app.textFields["AgeTextField"]
        ageTextField.tap()
        XCTAssertTrue(ageTextField.exists,"age textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "25")
        
        let sexTextField = app.textFields["SexTextField"]
        sexTextField.tap()
        XCTAssertTrue(sexTextField.exists,"sex textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "Male")
        
        let weightTextField = app.textFields["WeightTextField"]
        weightTextField.tap()
        XCTAssertTrue(weightTextField.exists,"weight textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "130")
        
        let emailTextField = app.textFields["EmailTextField"]
        emailTextField.tap()
        XCTAssertTrue(emailTextField.exists,"email textfield do not exist")
        emailTextField.typeText("123456@hotmail.com")
        //        let secondCell = cells.element(boundBy: 1)
        //        secondCell.tap()
        //        app.pickerWheels.element.adjust(toPickerWheelValue: "25")
        //        let thirdCell = cells.element(boundBy: 2)
        //        thirdCell.tap()
        //        app.pickerWheels.element.adjust(toPickerWheelValue: "Male")
        //        let fourthCell = cells.element(boundBy: 3)
        //        fourthCell.tap()
        //        app.pickerWheels.element.adjust(toPickerWheelValue: "130")
        //        let fifthCell = cells.element(boundBy: 4)
        //        fifthCell.tap()
        //        let textField = app.textFields
        //        XCTAssertTrue(heightTextField.exists,"text field do not exist")
        //        heightTextField.typeText("123456@hotmail.com")
        //XCTAssertEqual(heightTextField.value as! String, "123456@hotmail.com", "Text field is not correct")
        //tap button and tap tab to switch screens
        //need instance???
        let saveButton = app.buttons["SaveButton"]
        saveButton.tap()
        // Press save
        // Restart the app
        app.terminate()
        app.launch()
        
        // Validate the values are present still
        XCTAssertEqual(heightTextField.value as! String, "180", "height textfield is not correct")
        XCTAssertEqual(ageTextField.value as! String, "25", "age textfield is not correct")
        XCTAssertEqual(sexTextField.value as! String, "Male", "sex textfield is not correct")
        XCTAssertEqual(weightTextField.value as! String, "130", "weight textfield is not correct")
        XCTAssertEqual(emailTextField.value as! String, "123456@hotmail.com", "email textfield is not correct")
    }
    
    func testUserStatusController() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
		app.launch()
        exampleUserBot()
        
    }
    //NewDietButton
    func exampleUserGoal(){
        let app = XCUIApplication()
        let secondTab = app.tabBars.buttons.element(boundBy: 1)
        secondTab.tap()
        
        let tables = app.tables
        XCTAssertGreaterThan(tables.count, 0, "Table count is 0")
        
        let table = tables.element(boundBy: 0)
        XCTAssertTrue(table.exists, "Table one does not exist")
        let cells = table.cells
        XCTAssertGreaterThan(cells.count, 0, "table does not contain more than 0 cells")
        
        let lbsTextField = app.textFields["LbsTextField"]
        lbsTextField.tap()
        XCTAssertTrue(lbsTextField.exists,"lbs textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "2.0")
        
        let planButton = app.buttons["PlanButton"]
        planButton.tap()
        
        let idealWeightLabel = app.staticTexts["IdealWeightLabel"]
        let maintainWeightLabel = app.staticTexts["MaintainWeightLabel"]
        let planLabel = app.staticTexts["PlanLabel"]
        
        app.terminate()
        app.launch()
        
        XCTAssertEqual(lbsTextField.value as! String, "2.0", "lbs textfield is not correct")
        XCTAssertEqual(idealWeightLabel.label, "65-81", "idealWeight label is not correct")
        XCTAssertEqual(maintainWeightLabel.label, "2305.0", "maintainWeight label is not correct")
        XCTAssertEqual(planLabel.label, "You need to consume 1305.0 calories per day for 172 days", "plan label is not correct")
        
        //        IdealWeightTextField
        //        MaintainWeightTextField
        //        PlanTextField
        //        PlanButton
    }
    func testDailyCalorieController(){
        let app = XCUIApplication()
        app.launch()
        exampleUserBot()
        exampleUserGoal()
    }
    
    func testCalorieCalculationCOntroller(){
        let app = XCUIApplication()
        app.launch()
        exampleUserBot()
        exampleUserGoal()
        let thirdTab = app.tabBars.buttons.element(boundBy: 2)
        thirdTab.tap()
        
        let tables = app.tables
        XCTAssertGreaterThan(tables.count, 0, "Table count is 0")
        
        let table = tables.element(boundBy: 0)
        XCTAssertTrue(table.exists, "Table one does not exist")
        let cells = table.cells
        XCTAssertGreaterThan(cells.count, 0, "table does not contain more than 0 cells")
        
        //        CalculateButton
        //        CalorieLeftTextField
        let calculateButton = app.buttons["CalculateButton"]
        calculateButton.tap()
        let calorieLeftLabel = app.staticTexts["CalorieLeftLabel"]
        app.terminate()
        app.launch()
        
        XCTAssertEqual(calorieLeftLabel.label, "2305.0 cals", "calorieLeft label is not correct")
        
        let workoutCell = app.cells["WorkoutCell"]
        workoutCell.tap()
        let workoutsBar = app.navigationBars["Workouts"]
        let addworkoutButton = workoutsBar.buttons["Add Workout"]
        let backWorkoutButton = workoutsBar.buttons["Title"]
        
        addworkoutButton.tap()
        let exerciseTextField = app.textFields["ExerciseTextField"]
        exerciseTextField.tap()
        XCTAssertTrue(exerciseTextField.exists,"exercise textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "Kayaking")
        let durationTextField = app.textFields["DurationTextField"]
        durationTextField.tap()
        XCTAssertTrue(durationTextField.exists,"duration textfield do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "2.0")
        
        let workoutBar = app.navigationBars["Add Workout"]
        let saveWorkoutButton = workoutBar.buttons["Save"]
        saveWorkoutButton.tap()
        
        addworkoutButton.tap()
        exerciseTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Vinyasa Yoga")
        durationTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "1.5")
        saveWorkoutButton.tap()
        
        backWorkoutButton.tap()
        
//        //Workouts, Workout, Meals, Meal
//        WorkoutCell
//        MealCell
//        //accessibility
//
//        //Add Workout, Title go back
//        ExerciseTextField
//        DurationTextField
//        //Workouts go back
//
//        //Add Meal, Title go back
//        FoodTypeTextField
//        AmoutTextField
//        //Meals go back
        let mealCell = app.cells["MealCell"]
        mealCell.tap()
        let mealsBar = app.navigationBars["Meals"]
        let addMealButton = mealsBar.buttons["Add Meal"]
        let backMealButton = mealsBar.buttons["Title"]
        
        addMealButton.tap()
        let foodTypeTextField = app.textFields["FoodTypeTextField"]
        foodTypeTextField.tap()
        XCTAssertTrue(foodTypeTextField.exists,"foodType TextField do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "1 Apple (4 oz.)")
        let amoutTextField = app.textFields["AmoutTextField"]
        amoutTextField.tap()
        XCTAssertTrue(amoutTextField.exists,"Amout TextField do not exist")
        app.pickerWheels.element.adjust(toPickerWheelValue: "3.0")
        
        let mealBar = app.navigationBars["Add Meal"]
        let saveMealButton = mealBar.buttons["Save"]
        saveMealButton.tap()
        
        addMealButton.tap()
        foodTypeTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Dark Chocolate (1oz.)")
        amoutTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "2.5")
        saveMealButton.tap()
        
        backMealButton.tap()
        
        app.terminate()
        app.launch()
        
        
        workoutCell.tap()
        let tableWorkout = app.tables
        XCTAssertGreaterThan(tableWorkout.count, 0, "tableWorkout count is 0")
        
        let tableOfWorkout = tableWorkout.element(boundBy: 0)
        XCTAssertTrue(tableOfWorkout.exists, "tableOfWorkout does not exist")
        let cellsOfWorkout = tableOfWorkout.cells
        XCTAssertEqual(cellsOfWorkout.count, 2, "cellsOfWorkout does not contain 2 cells")
        backWorkoutButton.tap()
        
        mealCell.tap()
        let tableMeal = app.tables
        XCTAssertGreaterThan(tableMeal.count, 0, "tableMeal count is 0")
        
        let tableOfMeal = tableMeal.element(boundBy: 0)
        XCTAssertTrue(tableOfMeal.exists, "tableOfMeal does not exist")
        let cellsOfMeal = tableOfMeal.cells
        XCTAssertEqual(cellsOfMeal.count, 2, "cellsOfWorkout does not contain 2 cells")
        backMealButton.tap()
        
        calculateButton.tap()
        XCTAssertEqual(calorieLeftLabel.label, "1274.5 cals", "calorieLeft label is not correct")
    }
    
    func testAboutCOntroller(){
        let app = XCUIApplication()
        app.launch()
        
        let fourthTab = app.tabBars.buttons.element(boundBy: 3)
        fourthTab.tap()
        
        let tables = app.tables
        XCTAssertGreaterThan(tables.count, 0, "Table count is 0")
        
        let table = tables.element(boundBy: 0)
        XCTAssertTrue(table.exists, "Table one does not exist")
        let cells = table.cells
        XCTAssertGreaterThan(cells.count, 0, "table does not contain more than 0 cells")
        
        //        AboutInfoLabel
        let aboutInfoLabel = app.staticTexts["AboutInfoLabel"]
        XCTAssertTrue(aboutInfoLabel.exists, "aboutInfoLabel does not exist")
        XCTAssertEqual(aboutInfoLabel.label, "This app serves the purpose of tracking your losing-weight diet progress. The calories calculation of maintaining the suggested ideal weight is based on healthy BMI recommendation and is not considering your exercise activeness. If you are active in exercising, consume sightly more calories per day. All formulas are for adults age 18 or older.                                                                For losing weight healthily, you should not loss more than 2lbs per day (otherwise you would burn your muscle), and if you are trying to build your muscle at the same time, the formulas in this app might not be the best for you. As this app is only a general guide for your weight-loss diet, for any concerns, consult your doctor and nutritionist.", "The aboutInfoLabel value is not correct")
    }
}
