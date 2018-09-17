//
//  finalProjectTests.swift
//  finalProjectTests
//
//  Created by Fangjian Shang on 8/10/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import XCTest
@testable import finalProject

class finalProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
	func testExercises() {
		let service = DietService.shared

		let exercises = service.exercises()
		XCTAssertEqual(exercises.count, 12, "Unexpected number of exercises returned from service")

		// TODO: Validate each exercise based on what it's in the plist
        XCTAssertEqual(exercises[0].name, "Basketball(general)", "wrong name of exercises returned from service")
        XCTAssertEqual(exercises[0].caloriesPerHour, 422, "wrong caloriesPerHour of exercises returned from service")
        
        XCTAssertEqual(exercises[8].name, "Swimming(free-style, moderate)", "wrong name of exercises returned from service")
        XCTAssertEqual(exercises[8].caloriesPerHour, 492, "wrong caloriesPerHour of exercises returned from service")
        
        XCTAssertEqual(exercises[10].name, "Vinyasa Yoga", "wrong name of exercises returned from service")
        XCTAssertEqual(exercises[10].caloriesPerHour, 594, "wrong caloriesPerHour of exercises returned from service")
        
        XCTAssertEqual(exercises[9].name, "Tennis(general)", "wrong name of exercises returned from service")
        XCTAssertEqual(exercises[9].caloriesPerHour, 492, "wrong caloriesPerHour of exercises returned from service")
        
        XCTAssertEqual(exercises[11].name, "Walking(3.5 mph)", "wrong name of exercises returned from service")
        XCTAssertEqual(exercises[11].caloriesPerHour, 267, "wrong caloriesPerHour of exercises returned from service")
	}
    
    func testFoodType(){
        let service = DietService.shared
        let foodTypes = service.foodTypes()
        XCTAssertEqual(foodTypes.count, 41, "Unexpected number of foodTypes returned from service")
        
        XCTAssertEqual(foodTypes[0].name, "1 6\" Subway Turkey Sandwich", "wrong name of foodTypes returned from service")
        XCTAssertEqual(foodTypes[0].calorieperserving, 200, "wrong calorieperserving of foodTypes returned from service")
        
        XCTAssertEqual(foodTypes[13].name, "1 cup Broccoli", "wrong name of foodTypes returned from service")
        XCTAssertEqual(foodTypes[13].calorieperserving, 45, "wrong calorieperserving of foodTypes returned from service")
        
        XCTAssertEqual(foodTypes[17].name, "1 cup Eggplant", "wrong name of foodTypes returned from service")
        XCTAssertEqual(foodTypes[17].calorieperserving, 35, "wrong calorieperserving of foodTypes returned from service")
        
        XCTAssertEqual(foodTypes[24].name, "1 cup Tomato", "wrong name of foodTypes returned from service")
        XCTAssertEqual(foodTypes[24].calorieperserving, 22, "wrong calorieperserving of foodTypes returned from service")
        
        XCTAssertEqual(foodTypes[18].name, "1 cup Grapes (250 ml)", "wrong name of foodTypes returned from service")
        XCTAssertEqual(foodTypes[18].calorieperserving, 100, "wrong calorieperserving of foodTypes returned from service")
        
        XCTAssertEqual(foodTypes[40].name, "Tofu (4oz.)", "wrong name of foodTypes returned from service")
        XCTAssertEqual(foodTypes[40].calorieperserving, 86, "wrong calorieperserving of foodTypes returned from service")
    }

	func testCleanExerciseAndMeal() {
		let service = DietService.shared
		// Add a workout
        
        let firstExercise = service.exercises().first!
        let durationt: Double = 3
        do {
            try service.addWorkout(withExercise: firstExercise, andDuration: durationt)
        }
        catch {
            XCTFail("Caught error while adding workout")
        }
        let workouts = service.workouts()
		// Add a meal
        
        let firstMeal = service.foodTypes().first!
        let amount: Double = 10
        
        do {
            try service.addMeal(withFoodType: firstMeal, andAmount: amount)
        }
        catch {
            XCTFail("Caught error while adding meal")
        }
        let meals = service.meals()
		// Assert that workouts returns an array with at least 1 object in it
        XCTAssertEqual(workouts.count, 1, "workouts contains 0 item")
		// Assert that meals returns an array with at least 1 object in it
        XCTAssertEqual(meals.count, 1, "meals contains 0 item")

		// Call cleanExerciseAndMeal()
        try! service.cleanExerciseAndMeal()
        //Failed here
		// Assert that workouts returns an empty array
        XCTAssertEqual(workouts.count, 0, "Workouts not empty")
		// Assert that meals returns an empty array
        XCTAssertEqual(meals.count, 0, "Meals not empty")
	}

	func testWorkoutsResultsController() {
		let service = DietService.shared
		// Call cleanExerciseAndMeal
        try! service.cleanExerciseAndMeal()
		// Add a workout
        //var workouts = service.workouts()
        let firstExercise = service.exercises().first!
        let durationt: Double = 6
        do {
            try service.addWorkout(withExercise: firstExercise, andDuration: durationt)
        }
        catch {
            XCTFail("Caught error while adding workout")
        }
		// Call workoutsResultsController
        let fetchedResultsController = service.workoutsResultsController()
		// Assert that it has 1 section
		// Assert that there is 1 item in section 1
        if let numofsections = fetchedResultsController.sections?.count{
            XCTAssertGreaterThan(numofsections, 0, "Workout contains 0 sections")
        }else{
            XCTFail("Workout contains no sections")
        }
        
        if let sections = fetchedResultsController.sections {
            for section in sections {
                let numofitems = section.numberOfObjects
                XCTAssertGreaterThan(numofitems, 0, "Workout each section contains 0 items")
            }
        }
        else {
            XCTFail("Workout contained no sections")
        }
	}
    
    func testMealsResultsController(){
        let service = DietService.shared
        try! service.cleanExerciseAndMeal()
        
        let firstMeal = service.foodTypes().first!
        let amount: Double = 10
        
        do {
            try service.addMeal(withFoodType: firstMeal, andAmount: amount)
        }
        catch {
            XCTFail("Caught error while adding meal")
        }
        
        let fetchedResultsController = service.mealsResultsController()
        if let numofsections = fetchedResultsController.sections?.count{
            XCTAssertGreaterThan(numofsections, 0, "Meal contains 0 sections")
        }else{
            XCTFail("Meal contains no sections")
        }
        
        if let sections = fetchedResultsController.sections {
            for section in sections {
                let numofitems = section.numberOfObjects
                XCTAssertGreaterThan(numofitems, 0, "Meal each section contains 0 items")
            }
        }
        else {
            XCTFail("Meal contained no sections")
        }
        
    }

	func testWorkouts() {
		let service = DietService.shared

		try! service.cleanExerciseAndMeal()

		var workouts = service.workouts()
		let initialWorkoutCount = workouts.count

		let firstExercise = service.exercises().first!
		let durationt: Double = 10
		do {
			try service.addWorkout(withExercise: firstExercise, andDuration: durationt)
		}
		catch {
			XCTFail("Caught error while adding workout")
		}

		workouts = service.workouts()
		let adjustedWorkoutCount = workouts.count

		XCTAssertEqual(adjustedWorkoutCount, initialWorkoutCount + 1, "Workouts did not contain one new workout")

		let lastWorkout = workouts.last!
		XCTAssertNotNil(lastWorkout.exercise, "New workout did not contain an exercise")
		XCTAssertEqual(lastWorkout.exercise!, firstExercise, "New workout did not contain expected exercise")

		XCTAssertEqual(lastWorkout.duration, durationt, "New workout did not contain expected duration")
        
	}
    
    func testEditWorkout(){
        let service = DietService.shared
        
        try! service.cleanExerciseAndMeal()
        
        var workouts = service.workouts()
        let firstExercise = service.exercises().first!
        let durationt: Double = 10
        do {
            try service.addWorkout(withExercise: firstExercise, andDuration: durationt)
        }
        catch {
            XCTFail("Caught error while adding workout")
        }
        //Is this last not the first exercise???
        workouts = service.workouts()
        let lastWorkout = workouts.last!
        XCTAssertNotNil(lastWorkout.exercise, "New workout did not contain an exercise")
        XCTAssertEqual(lastWorkout.exercise!, firstExercise, "New workout did not contain expected exercise")
        
        XCTAssertEqual(lastWorkout.duration, durationt, "New workout did not contain expected duration")
        
        do {
            try service.editWorkout(lastWorkout, withNewExercise: service.exercises()[11], andDuration: 5)
        }
        catch {
            XCTFail("Caught error while editing workout")
        }
        XCTAssertEqual(lastWorkout.exercise?.name, "Walking(3.5 mph)", "wrong name of Workout returned from service")
        XCTAssertEqual(lastWorkout.exercise?.caloriesPerHour, 267, "wrong caloriesPerHour of Workout returned from service")
        XCTAssertEqual(lastWorkout.duration, 5, "wrong duration of Workout returned from service")
    }
    
    func testDeleteWorkout(){
        let service = DietService.shared
        
        try! service.cleanExerciseAndMeal()
        
        var workouts = service.workouts()
        let initialWorkoutCount = workouts.count
        
        let firstExercise = service.exercises().first!
        let durationt: Double = 10
        do {
            try service.addWorkout(withExercise: firstExercise, andDuration: durationt)
        }
        catch {
            XCTFail("Caught error while adding workout")
        }
        workouts = service.workouts()
        let lastWorkout = workouts.last!
        XCTAssertNotNil(lastWorkout.exercise, "New workout did not contain an exercise")
        XCTAssertEqual(lastWorkout.exercise!, firstExercise, "New workout did not contain expected exercise")
        
        XCTAssertEqual(lastWorkout.duration, durationt, "New workout did not contain expected duration")
        
        do {
            try service.delete(lastWorkout)
        }
        catch {
            XCTFail("Caught error while deleting workout")
        }
        workouts = service.workouts()
        let updatedWorkoutCount = workouts.count
        XCTAssertEqual(updatedWorkoutCount, initialWorkoutCount, "Workouts did not contain same number of workout as the initialWorkoutCount")
    }
    
    func testMeals(){
        let service = DietService.shared
        
        try! service.cleanExerciseAndMeal()
        
        var meals = service.meals()
        let initialMealCount = meals.count
        
        let firstMeal = service.foodTypes().first!
        let amount: Double = 10
        
        do {
            try service.addMeal(withFoodType: firstMeal, andAmount: amount)
        }
        catch {
            XCTFail("Caught error while adding meal")
        }
        
        meals = service.meals()
        let updatedMealCount = meals.count
        
        XCTAssertEqual(updatedMealCount, initialMealCount + 1, "Meals did not contain one new meal")
        
        let lastMeal = meals.last!
        XCTAssertNotNil(lastMeal.foodType, "New meal did not contain a foodType")
        XCTAssertEqual(lastMeal.foodType!, firstMeal, "New meal did not contain expected foodType")
        
        XCTAssertEqual(lastMeal.amount, amount, "New meal did not contain expected amount")
        
        
        ///
//        do {
//            try service.editMeal(lastMeal, withNewFoodType: service.foodTypes()[40], andAmount: 10)
//        }
//        catch {
//            XCTFail("Caught error while editing meal")
//        }
//        XCTAssertEqual(lastMeal.foodType?.name, "1 cup Yogurt (non-fat)", "wrong name of Meal returned from service")
//        XCTAssertEqual(lastMeal.foodType?.calorieperserving, 110, "wrong calorieperserving of Meal returned from service")
//        XCTAssertEqual(lastMeal.amount, 10, "wrong amount of Meal returned from service")
//
//        do {
//            try service.delete(lastMeal)
//        }
//        catch {
//            XCTFail("Caught error while deleting Meal")
//        }
//        meals = service.meals()
//        let adjustedMealCount = meals.count
//        XCTAssertEqual(adjustedMealCount, initialMealCount, "Meals did not contain same number of Meal as the initialMealCount")

        
    }
    
    func testEditMeal(){
        let service = DietService.shared
        
        try! service.cleanExerciseAndMeal()
        
        var meals = service.meals()
        let firstMeal = service.foodTypes().first!
        let amount: Double = 10
        
        do {
            try service.addMeal(withFoodType: firstMeal, andAmount: amount)
        }
        catch {
            XCTFail("Caught error while adding meal")
        }
        meals = service.meals()
        let lastMeal = meals.last!
        XCTAssertNotNil(lastMeal.foodType, "New meal did not contain a foodType")
        XCTAssertEqual(lastMeal.foodType!, firstMeal, "New meal did not contain expected foodType")
        
        XCTAssertEqual(lastMeal.amount, amount, "New meal did not contain expected amount")
        
        do {
            try service.editMeal(lastMeal, withNewFoodType: service.foodTypes()[40], andAmount: 10)
        }
        catch {
            XCTFail("Caught error while editing meal")
        }
        XCTAssertEqual(lastMeal.foodType?.name, "Tofu (4oz.)", "wrong name of Meal returned from service")
        XCTAssertEqual(lastMeal.foodType?.calorieperserving, 86, "wrong calorieperserving of Meal returned from service")
        XCTAssertEqual(lastMeal.amount, 10, "wrong amount of Meal returned from service")
    }
    
    func testDeleteMeal(){
        let service = DietService.shared
        
        try! service.cleanExerciseAndMeal()
        
        var meals = service.meals()
        let initialMealCount = meals.count
        
        let firstMeal = service.foodTypes().first!
        let amount: Double = 10
        
        do {
            try service.addMeal(withFoodType: firstMeal, andAmount: amount)
        }
        catch {
            XCTFail("Caught error while adding meal")
        }
        meals = service.meals()
        let lastMeal = meals.last!
        XCTAssertNotNil(lastMeal.foodType, "New meal did not contain a foodType")
        XCTAssertEqual(lastMeal.foodType!, firstMeal, "New meal did not contain expected foodType")
        
        XCTAssertEqual(lastMeal.amount, amount, "New meal did not contain expected amount")
        
        do {
            try service.delete(lastMeal)
        }
        catch {
            XCTFail("Caught error while deleting Meal")
        }
        meals = service.meals()
        let adjustedMealCount = meals.count
        XCTAssertEqual(adjustedMealCount, initialMealCount, "Meals did not contain same number of Meal as the initialMealCount")
    }
}
