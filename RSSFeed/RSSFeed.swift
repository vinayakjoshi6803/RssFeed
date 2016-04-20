//
//  RSSFeed.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/18/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
import CoreData

enum XMLField : String {
    case ITEM = "item", TITLE = "title", DESCRIPTION = "description", LINK = "imageUrl"
}

public class Event: NSManagedObject {
   @NSManaged var title: String!
   @NSManaged var descriptions: String!
   @NSManaged var imageUrl: String!
}


class RSSFeed: NSObject {

    let baseURL = "http://feeds.reuters.com/reuters/MostRead"
    let parseQueue = NSOperationQueue()
    lazy var events : [Event] = [Event]()
    var sessionTask: NSURLSessionDataTask!
    
    func loadFeed(){
    
        let url = NSURL(string: baseURL)
        self.sessionTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?,response: NSURLResponse?,error: NSError?) in
           
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                if (error != nil || response == nil) {
                    return
                }
                let event = EventParser(data: data!)
                self.parseQueue.addOperation(event)
            })
        })
        
        self.sessionTask.resume()
    }
    
}