//
//  CatService.swift
//  Assignment4
//


import Foundation


class CatService {
	// MARK: Service
	func catCategories() -> Array<(title: String, subtitle: String)> {
		// TODO: Remove the fatalError call and return an array of tuples, where each tuple contains the title of the category and the subtitle text
		//fatalError("catCategories() not implemented")
        //let imageNum = ($0["ImageNames"] as! Array<String>).count
        return catValues.map({ ($0["CategoryTitle"] as! String, "Contains \(($0["ImageNames"] as! Array<String>).count) images") })
	}

	func imageNamesForCategory(atIndex index: NSInteger) -> Array<String> {
		// TODO: Remove the fatalError call and return the array of image names for the cat category specified by the index
		//fatalError("imageNamesForCategory(atIndex:) not implemented")
        return catValues[index]["ImageNames"] as! Array<String>
	}

	// MARK: Initialization
	private init() {
		let catValuesDataURL = Bundle.main.url(forResource: "CatValues", withExtension: "plist")!
		let catValuesData = try! Data(contentsOf: catValuesDataURL)
		catValues = try! PropertyListSerialization.propertyList(from: catValuesData, options: [], format: nil) as! Array<Dictionary<String, Any>>
	}

	// MARK: Properties (Private)
	private let catValues: Array<Dictionary<String, Any>>

	// MARK: Properties (Private, Constant)
	private let titleKey = "CategoryTitle"
	private let imageNamesKey = "ImageNames"

	// MARK: Properties (Static)
	static let shared = CatService()
}
