//
//  Categoria+CoreDataProperties.swift
//  Budget
//
//  Created by Calebe Santos on 3/31/16.
//  Copyright © 2016 Budget Company. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Categoria {

    @NSManaged var nome: String?
    @NSManaged var despesa: NSSet?
    @NSManaged var receita: NSSet?

}
