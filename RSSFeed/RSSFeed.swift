//
//  RSSFeed.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/18/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation

enum XMLField : String {
    case ITEM = "item", TITLE = "title", DESCRIPTION = "description", LINK = "link"
}

public class Event: NSObject {
   dynamic var title: String!
   dynamic var descriptions: String!
   dynamic var link: String!
}

class EventParser: NSOperation, NSXMLParserDelegate {
   
    private var isItemStart = false
    private var strFieldValue: String = ""
    private var event: Event!
    private var nsxmlParser: NSXMLParser!
    lazy var events : [Event] = [Event]()

    convenience init(data: NSData) {
        self.init()
        
        nsxmlParser = NSXMLParser.init(data: data)
        nsxmlParser.delegate = self
        nsxmlParser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
       
        switch elementName as XMLField.RawValue {
        
        case XMLField.ITEM.rawValue:
                isItemStart = true
                self.event = Event()
            break
        default:
            break
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if !isItemStart {return}
        
        strFieldValue += string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if !isItemStart {return}
        
        switch elementName as XMLField.RawValue {
            
        case XMLField.ITEM.rawValue:
            isItemStart = false
            break
        case XMLField.TITLE.rawValue:
            self.event.title = strFieldValue
            break
        case XMLField.DESCRIPTION.rawValue:
            self.event.descriptions = strFieldValue
            break
        case XMLField.LINK.rawValue:
            self.event.link = strFieldValue
            break
            
        default:
            break
        }
        strFieldValue=""
        self.events.append(event)
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        addEventsToStorage()
    }
    
    private func addEventsToStorage(){
        
    }
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