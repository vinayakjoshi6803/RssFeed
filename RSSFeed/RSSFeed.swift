//
//  RSSFeed.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/18/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
import CoreData


// XMLField defines the element keys in the xml
enum XMLField : String {
    case ITEM = "item", TITLE = "title", DESCRIPTION = "description", LINK = "link"
}

public class RSSEvent: NSManagedObject {
   @NSManaged var title: String!
   @NSManaged var descriptions: String!
   @NSManaged var imageUrl: String!
}


class RSSFeed: NSObject {

    let baseURL = "http://feeds.reuters.com/reuters/MostRead"
    let parseQueue = NSOperationQueue()
    lazy var events : [RSSEvent] = [RSSEvent]()
    var sessionTask: NSURLSessionDataTask!
    
    func loadFeed(){
    
        let url = NSURL(string: baseURL)
        
        _ = RSSServiceManager.init(url: url!, success: { (data) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                let event = RSSEventParser(data: data!)
                self.parseQueue.addOperation(event)
            })
        })
        { (error) in
            print(error)
        }
    }
}



