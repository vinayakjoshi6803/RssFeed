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


public class RSSFeed: NSObject {

    let baseURL = "http://feeds.reuters.com/reuters/MostRead"

    func loadFeed(){
    
        let url = NSURL(string: baseURL)
        
        _ = RSSServiceManager.init(url: url!, success: { (data) in
                _ = RSSEventParser(data: data!)
        })
        { (error) in
            print(error)
        }
    }
}



