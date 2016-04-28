//
//  RSSEvent.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/27/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
import CoreData

public class RSSEvent: NSManagedObject {
    @NSManaged var title: String!
    @NSManaged var descriptions: String!
    @NSManaged var linkURL: String!
}