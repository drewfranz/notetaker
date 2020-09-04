//
//  Note+CoreDataProperties.swift
//  Note Taker
//
//  Created by Drew Franz on 9/3/20.
//  Copyright © 2020 Drew Franz. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
