//
//  CatService.swift
//  Arsignmentu
//


import CoreData
import Foundation


class CatService {
    // MARK: Service
    func catCategories() -> NSFetchedResultsController<Category>? {
        // TODO: Update this method to utilize CoreData

        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "categorytitle", ascending: true)]
        
        var fetchedResultsController: NSFetchedResultsController<Category>? = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController?.performFetch()
        }
        catch {
            fetchedResultsController = nil
        }
        
        return fetchedResultsController
    }

    func images(for category: Category) -> NSFetchedResultsController<Image>? {
        // TODO: Update this method to utilize CoreData

        let request: NSFetchRequest<Image> = Image.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", category)
        request.sortDescriptors = [NSSortDescriptor(key: "orderingvalue", ascending: true)]
        
        var fetchedResultsController: NSFetchedResultsController<Image>? = NSFetchedResultsController(fetchRequest: request, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController?.performFetch()
        }
        catch {
            fetchedResultsController = nil
        }
        
        return fetchedResultsController
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
            
            let content = self.persistentContainer.newBackgroundContext()
            content.perform {
                let catRequest: NSFetchRequest<Category> = Category.fetchRequest()
                let count = (try? content.count(for: catRequest)) ?? 0
                guard count == 0 else {
                    return
                }
                
                for catContent in catValues {
                    let category = Category(context: content)
                    let title = catContent["CategoryTitle"] as! String
                    category.categorytitle = title
                    
                    let imageNames = catContent["ImageNames"] as! Array<String>
                    for tuple in imageNames.enumerated() {
                        let image = Image(context: content)
                        image.imagename = tuple.element
                        image.orderingvalue = Int32(tuple.offset)
                        
                        category.addToImages(image)
                    }
                }
//              crash if fail
                try! content.save()
//                do {
//                    try content.save()
//                }
//                catch _ {
//                    fatalError("Failure Message")
//                }
            }
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
