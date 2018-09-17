//
//  DietService.swift
//  finalProject
//
//  Created by Fangjian Shang on 8/14/18.
//  Copyright © 2018 Fangjian Shang. All rights reserved.
//

import CoreData
import UIKit

class DietService {
    //Private
    private let persistentContainer: NSPersistentContainer
    
    //Static Constant
    static let shared = DietService()
    
    //Initialization
    private init() {
        persistentContainer = NSPersistentContainer(name: "finalProject")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let someError = error as NSError? {
                fatalError("Error loading persistent store \(someError)")
            }

            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

			let context = self.persistentContainer.newBackgroundContext()

			let exerciseValuesDataURL = Bundle.main.url(forResource: "Exercises", withExtension: "plist")!
			let exerciseValuesData = try! Data(contentsOf: exerciseValuesDataURL)
			let exerciseValues = try! PropertyListSerialization.propertyList(from: exerciseValuesData, options: [], format: nil) as! Array<Dictionary<String, Any>>
			context.perform {
				let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
				let count = try! context.count(for: fetchRequest)
				guard count == 0 else {
					// Exercise data already exists
					return
				}

				for exerciseValues in exerciseValues {
					let exercise = Exercise(context: context)
					exercise.name = (exerciseValues["Name"] as! String)
					exercise.caloriesPerHour = (exerciseValues["CaloriesPerHour"] as! Int32)
				}

				try! context.save()
			}
            //Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
			let foodTypeValuesDataURL = Bundle.main.url(forResource: "FoodTypes", withExtension: "plist")!
            //Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
            
			let foodTypeValuesData = try! Data(contentsOf: foodTypeValuesDataURL)
			let foodTypeValues = try! PropertyListSerialization.propertyList(from: foodTypeValuesData, options: [], format: nil) as! Array<Dictionary<String, Any>>
			context.perform {
				let fetchRequest: NSFetchRequest<FoodType> = FoodType.fetchRequest()
				let count = try! context.count(for: fetchRequest)
				guard count == 0 else {
					// Exercise data already exists
					return
				}

				for foodTypeValues in foodTypeValues {
					let foodType = FoodType(context: context)
					foodType.name = (foodTypeValues["Name"] as! String)
                    foodType.calorieperserving = (foodTypeValues["CaloriePerServing"] as! Int32)
				}

				try! context.save()
			}
        })
    }
    //delete method:
    //make fetch requests, execute and delete
    func cleanExerciseAndMeal() throws {
        let fetchRequest1: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest1.includesPropertyValues = false
		let meals = try persistentContainer.viewContext.fetch(fetchRequest1)
		for meal in meals {
			persistentContainer.viewContext.delete(meal)
		}

        let fetchRequest2: NSFetchRequest<Workout> = Workout.fetchRequest()
		fetchRequest2.includesPropertyValues = false
		let workouts = try persistentContainer.viewContext.fetch(fetchRequest2)
		for workout in workouts {
			persistentContainer.viewContext.delete(workout)
		}

		try persistentContainer.viewContext.save()
	}
    
	// Exercises Picker
	func exercises() -> Array<Exercise> {
		let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

		return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
	}

	// FoodTypes Picker
	func foodTypes() -> Array<FoodType> {
		let fetchRequest: NSFetchRequest<FoodType> = FoodType.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

		return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
	}

	// Workouts List Screen
	func workoutsResultsController() -> NSFetchedResultsController<Workout> {
		let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]

		return fetchedResultsController(for: fetchRequest)
	}

	func delete(_ workout: Workout) throws {
		let context = persistentContainer.viewContext
		context.delete(workout)

		try context.save()
	}

	// Workout Details Screen
	func addWorkout(withExercise exercise: Exercise, andDuration duration: Double) throws {
		let context = persistentContainer.viewContext

		let workout = Workout(context: context)
		workout.exercise = exercise
		workout.duration = duration

		try context.save()
	}

	func editWorkout(_ workout: Workout, withNewExercise exercise: Exercise, andDuration duration: Double) throws {
		workout.exercise = exercise
		workout.duration = duration

		let context = persistentContainer.viewContext
		try context.save()
	}

	// Meals List Screen
	func mealsResultsController() -> NSFetchedResultsController<Meal> {
		let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]

		return fetchedResultsController(for: fetchRequest)
	}

	func delete(_ meal: Meal) throws {
		let context = persistentContainer.viewContext
		context.delete(meal)

		try context.save()
	}

	// Meals Detail Screen
	func addMeal(withFoodType foodType: FoodType, andAmount amount: Double) throws {
		let context = persistentContainer.viewContext

		let meal = Meal(context: context)
		meal.foodType = foodType
		meal.amount = amount

		try context.save()
	}

	func editMeal(_ meal: Meal, withNewFoodType foodType: FoodType, andAmount amount: Double) throws {
		meal.foodType = foodType
		meal.amount = amount

		let context = persistentContainer.viewContext
		try context.save()
	}

	// Calculation
	func workouts() -> Array<Workout> {
		let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false

		return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
	}

	func meals() -> Array<Meal> {
		let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false

		return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
	}

	// Private - Utility
	private func fetchedResultsController<T>(for fetchRequest: NSFetchRequest<T>) -> NSFetchedResultsController<T> where T: NSManagedObject {
		let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
		try! fetchedResultsController.performFetch()

		return fetchedResultsController
	}
}
