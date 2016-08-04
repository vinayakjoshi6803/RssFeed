//
//  RSSServiceManager.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/20/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
// RSSServiceManager: takes url as input pull the repsonse and returns to the calles
class RSSServiceManager{
    
    convenience init(url:NSURL, success: (data: NSData?)-> Void, failure:(error: NSError?)-> Void){
        self.init()
        
        let sessionTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data: NSData?,response: NSURLResponse?,error: NSError?) in
            
            if (error != nil ){
                failure(error: error)
                NSNotificationCenter.defaultCenter().postNotificationName("NetworkError", object: nil)
            }else if ( response == nil){
                failure(error: error)
                NSNotificationCenter.defaultCenter().postNotificationName("Server error/ no response", object: nil)
            }else{
                success(data: data)
            }
        })
        sessionTask.resume()
    }
    
}