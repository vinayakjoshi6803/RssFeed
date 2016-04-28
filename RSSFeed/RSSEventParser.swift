//
//  EventParser.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/19/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation
import CoreData

class RSSEventParser: NSOperation, NSXMLParserDelegate {
    
    private var isItemStart = false
    private var strFieldValue: String = ""
    private var event: RSSEvent!
    private var nsxmlParser: NSXMLParser!
    lazy var events : [RSSEvent] = [RSSEvent]()
    
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
            let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: RSSCoreDataManager.sharedManager.managedObjectContext )
            self.event = RSSEvent.init(entity: entity!, insertIntoManagedObjectContext: nil)// Event.init(entity: entity!, insertIntoManagedObjectContext: nil)
            
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
            self.events.append(event)
            break
        case XMLField.TITLE.rawValue:
            self.event.title = strFieldValue
            break
        case XMLField.DESCRIPTION.rawValue:
            self.event.descriptions = strFieldValue
            break
        case XMLField.LINK.rawValue:
            self.event.linkURL = strFieldValue
            break
            
        default:
            break
        }
        strFieldValue=""
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.addEventsToStorage()
        })
    }
    
    private func addEventsToStorage(){
        // create an instance of our managedObjectContext
        let moc = RSSCoreDataManager.sharedManager.managedObjectContext
        RSSCoreDataManager.sharedManager.deleteOldFeeds("Event")
        for event in self.events {
                moc.insertObject(event)
        }
        RSSCoreDataManager.sharedManager.saveContext()
    }
}
