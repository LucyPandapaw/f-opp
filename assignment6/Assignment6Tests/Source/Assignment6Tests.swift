//
//  Assignment6Tests.swift
//  Assignment6Tests
//

import UIKit
import XCTest
@testable import Assignment6

class Assignment6Tests: XCTestCase {
    func testCatServicecatCategories(){
        //CatService singleton instance
        let singleton = CatService.shared
        //call its categories()
        let fetchedResultsController = singleton.catCategories()
        //check sections and items of each sections
        if let numofsections = fetchedResultsController.sections?.count{
            XCTAssertGreaterThan(numofsections, 0, "catCategories() CatService fetchedResultsController contains 0 sections")
        }else{
            XCTFail("catCategories() CatService fetchedResultsController contains no sections")
        }
        
        if let sections = fetchedResultsController.sections {
            for section in sections {
                let numofitems = section.numberOfObjects
                XCTAssertGreaterThan(numofitems, 0, "catCategories() each section contains 0 items")
            }
        }
        else {
            XCTFail("catCategories() CatService fetchedResultsController contained no sections")
        }
    }
    func testCatserviceimages(){
        //CatService singleton instance
        let singleton = CatService.shared
        //call its categories()
        let fetchedResultsController = singleton.catCategories()
        guard let catimages = fetchedResultsController.fetchedObjects else {
            XCTFail("catCategories() CatService fetchedResultsController contained no objects")
            return
        }
        //check sections and items of each sections
        for item in catimages {
            let catfetchedResultsController = singleton.images(for: item)
            if let numofsections = catfetchedResultsController.sections?.count{
                XCTAssertGreaterThan(numofsections, 0, "images() CatService fetchedResultsController contains 0 sections")
            }else{
                XCTFail("images() CatService fetchedResultsController contains no sections")
            }
            if let sections = catfetchedResultsController.sections {
                for section in sections {
                    let numofitems = section.numberOfObjects
                    XCTAssertGreaterThan(numofitems, 0, "catCategories() each section contains 0 items")
                }
            }
            else {
                XCTFail("catCategories() CatService fetchedResultsController contained no sections")
            }
        }
    }
}
