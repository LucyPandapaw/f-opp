//
//  Category+CoreDataClass.swift
//  Assignment5
//
//  Created by Fangjian Shang on 7/29/18.
//
//

import Foundation
import CoreData

public class Category: NSManagedObject{
    var subtitle: String{
        get{
            let count = images?.count ?? 0
            return "Contains \(count) image\(count == 1 ? "" : "s")"
        }
    }
    
    
}
