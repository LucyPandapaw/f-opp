//
//  CatService.swift
//  Assignment5
//


import CoreData
import Foundation


class CatService {
	// MARK: Service
	func catCategories() -> Array<(title: String, subtitle: String)> {
		// TODO: Update this method to utilize CoreData

		let catValuesDataURL = Bundle.main.url(forResource: "CatValues", withExtension: "plist")!
		let catValuesData = try! Data(contentsOf: catValuesDataURL)
		let catValues = try! PropertyListSerialization.propertyList(from: catValuesData, options: [], format: nil) as! Array<Dictionary<String, Any>>

		return catValues.map { values in
			let title = values[titleKey] as! String
			let imageNames = values[imageNamesKey] as! Array<String>

			return (title, "Contains \(imageNames.count) images")
		}
	}

	func imageNamesForCategory(atIndex index: NSInteger) -> Array<String> {
		// TODO: Update this method to utilize CoreData

		let catValuesDataURL = Bundle.main.url(forResource: "CatValues", withExtension: "plist")!
		let catValuesData = try! Data(contentsOf: catValuesDataURL)
		let catValues = try! PropertyListSerialization.propertyList(from: catValuesData, options: [], format: nil) as! Array<Dictionary<String, Any>>

		return catValues[index][imageNamesKey] as! Array<String>
	}

	// MARK: Initialization
	private init() {
		persistentContainer = NSPersistentContainer(name: "Model")

		persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
			self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

			let catValuesDataURL = Bundle.main.url(forResource: "CatValues", withExtension: "plist")!
			let catValuesData = try! Data(contentsOf: catValuesDataURL)
			let catValues = try! PropertyListSerialization.propertyList(from: catValuesData, options: [], format: nil) as! Array<Dictionary<String, Any>>

			// TODO: Store the cat data in CoreData if it is not already present
		})
	}

	// MARK: Private
	private let persistentContainer: NSPersistentContainer

	// MARK: Properties (Private, Constant)
	private let titleKey = "CategoryTitle"
	private let imageNamesKey = "ImageNames"

	// MARK: Properties (Static)
	static let shared = CatService()
}
