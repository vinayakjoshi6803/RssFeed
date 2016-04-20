//
//  RSSServiceManager.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/20/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation

class RSSServiceManager:NSObject{
    
    convenience init(url:NSURL, success: (data: NSData?)-> Void, failure:(error: NSError?)-> Void){
        self.init()
        
        let sessionTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data: NSData?,response: NSURLResponse?,error: NSError?) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                if (error != nil || response == nil) {
                    failure(error: error)
                }
                success(data: data)
            })
        })
        sessionTask.resume()
    }
    
}